require 'httparty'
require 'hpricot'
require 'base64'
require 'ostruct'
#require 'intuit_saml'
# CompanyID: 198248836
# Quickbooks Online Module
#
module Quickbooks

  COMPANY_ID = "198248836"
  APP_TOKEN = "dmbtq37kinfqnd53tgnvb4i6sbs"
  DB_ID = "bf4azdea3"
  PRIVATE_KEY = "key"
  
  # realm = Company ID
  # apptoken = App Token
  #
  def gateway
    puts "Params: " + params.inspect
    # Grab SAML message passed from IPP
    saml_response = params['SAMLResponse']

    # Decode SAML response and pass into Saml helper to decrypt
    saml = Intuit::Saml.new(:saml_xml => Base64.decode64(saml_response), :private_key => PRIVATE_KEY)

    # use the IPP Web API call API_GetIDSRealm to find the realm which is required for IDS
    options = {
      :act => 'API_GetIDSRealm',
      :ticket => saml.ticket,
      :apptoken => APP_TOKEN
    }
    response = HTTParty.get("https://workplace.intuit.com/db/#{DB_ID}?" + build_query(options))
    realm = Hpricot.XML(response.body).at('realm').inner_text

    # Setup the post to query customers from IDS
    body = '<CustomerQuery xmlns="http://www.intuit.com/sb/cdm/xmlrequest" />'
    auth_header = %(INTUITAUTH intuit-app-token="#{APP_TOKEN}",intuit-token="#{saml.ticket}")
    path = "https://services.intuit.com/sb/customer/v1/#{realm}"
    options = {
      :headers => { 'Authorization' => auth_header, 'Content-Type' =>'text/xml' },
      :body => body,
      :format => :donotparse
    }

    # Make call to IDS and receive the XML payload
    response = HTTParty.post(path, options)

    puts "Query Response: " + response.inspect

    # Hpricot payload and pull out customer names for display
    doc = Hpricot.XML(response)
    @customers = []
    doc.search('Customer').each do |node|
      @customers << OpenStruct.new(:name => (node/'cmo:Name').inner_text)
    end

    @customers  
  end
end
