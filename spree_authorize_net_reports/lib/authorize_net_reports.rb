module AuthorizeNetReports
  module_function
  def batches(from_date = Time.now.at_beginning_of_month, to_date = Time.now.at_end_of_month, include_statistic = true)
    response = report.get_settled_batch_list(from_date, to_date, include_statistic)
    response.success? ? (response.batch_list || []) : []
  end

#  module_function
  def transactions(batch_id)
    response = report.get_transaction_list(batch_id)
    response.success? ? (response.transactions || []) : []
  end

#  module_function
  def transaction(transaction_id)
    response = report.get_transaction_details(transaction_id)
    response.success? ? response.transaction : nil
  end
 
  def report
    AuthorizeNet::Reporting::Transaction.new(api_login_id, api_key, :gateway => gateway.to_sym)
  end

  def api_login_id
    Spree::Config[:authorize_net_api_login]
  end

  def api_key
    Spree::Config[:authorize_net_api_key]
  end

  def gateway
    Spree::Config[:authorize_net_api_gateway]
  end
end