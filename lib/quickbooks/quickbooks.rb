require 'nokogiri'
require 'open-uri'
# CompanyID: 198248836
# Quickbooks Online Module
#
module Quickbooks
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    # realm = Company ID
    # apptoken = App Token
    #
    def attach_ids_realm
      response = Nokogiri::XML( open( "https://workplace.intuit.com/db/bdb5rjd6h?act=API_AttachIDSRealm&realm=198248836&apptoken=dtmd897bfsw85bb6bneceb6wnze3" ) )
      # parse response

    end
  end
  
end
