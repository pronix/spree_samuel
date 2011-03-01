module AuthorizeNetReports::AuthorizeNet::Reporting

  # Models a fraud detection filter.
  class FDSFilter
    
    include AuthorizeNetReports::AuthorizeNet::Model
    
    attr_accessor :name, :action
  end

end