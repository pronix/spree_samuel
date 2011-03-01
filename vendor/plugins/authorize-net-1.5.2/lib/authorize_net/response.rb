module AuthorizeNetReports::AuthorizeNet
  
  # The core, API agnostic response class. You shouldn't instantiate this one.
  # Instead you should use AuthorizeNetReports::AuthorizeNet::AIM::Response, AuthorizeNetReports::AuthorizeNet::ARB::Response or AuthorizeNetReports::AuthorizeNet::SIM::Response.
  class Response
    
    include AuthorizeNetReports::AuthorizeNet::TypeConversions
        
    # Fields to convert to/from booleans.
    @@boolean_fields = []

    # Fields to convert to/from BigDecimal.
    @@decimal_fields = []
    
    # DO NOT USE. Instantiate AuthorizeNetReports::AuthorizeNet::AIM::Response or AuthorizeNetReports::AuthorizeNet::SIM::Response instead.
    def initialize()
      raise "#{self.class.to_s} should not be instantiated directly."
    end
    
    # Check to see if the response indicated success.
    def success?
      false
    end
    
  end
  
end