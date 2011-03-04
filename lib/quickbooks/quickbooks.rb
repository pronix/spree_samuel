require 'nokogiri'
require 'open-uri'
# CompanyID: 198248836
# Quickbooks Online Module
#
module Quickbooks

  COMPANY_ID = "198248836"
  APP_TOKEN = "dmbtq37kinfqnd53tgnvb4i6sbs"
  DB_ID = 1
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    # realm = Company ID
    # apptoken = App Token
    #
    def post
      response = Nokogiri::XML( open( "https://workplace.intuit.com/db/#{DB_ID}?act=API_AttachIDSRealm&realm=#{COMPANY_ID}&apptoken=#{APP_TOKEN}" ) )
      # parse response

    end
  end
  
end
