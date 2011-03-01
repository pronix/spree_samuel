class Admin::TransactionsController < Admin::BaseController
  helper :products
  
  def index
    @from_date, @to_date = get_date_range(params[:month])
    batches = AuthorizeNetReportsInterface.batches(@from_date, @to_date)
    @batches_with_transactions = batches.collect{|batch| [batch, AuthorizeNetReports.transactions(batch.id)]}.sort_by { |batch, transactions|  batch.settled_at }.reverse
  end

  def show
    @transaction = AuthorizeNetReportsInterface.transaction(params[:id])
    render :text => "Not found", :status => 404 and return false unless @transaction
  end

  private
    def get_date_range(month)
      date = month.blank? ? Time.now : Time.parse(month)
      [date.beginning_of_month, date.end_of_month]
    end
end