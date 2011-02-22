Admin::ReportsController.class_eval do

  def sales_total
    params[:search] = {} unless params[:search]

    if params[:search][:created_at_greater_than].blank?
      params[:search][:created_at_greater_than] = Time.zone.now.beginning_of_month
    else
      params[:search][:created_at_greater_than] = Time.zone.parse(params[:search][:created_at_greater_than]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:search] && !params[:search][:created_at_less_than].blank?
      params[:search][:created_at_less_than] = Time.zone.parse(params[:search][:created_at_less_than]).end_of_day rescue ""
    end

    params[:search][:completed_at_not_null] ||= "1"
    if params[:search].delete(:completed_at_not_null) == "1"
      params[:search][:completed_at_not_null] = true
    end

    params[:search][:order] ||= "descend_by_created_at"

    @search = orders_current_user.searchlogic(params[:search])
    @orders = @search.do_search

    @item_total = @search.do_search.sum(:item_total)
    @adjustment_total = @search.do_search.sum(:adjustment_total)
    @sales_total = @search.do_search.sum(:total)
  end


  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(:seller, self.class) : authorize!( :admin, Object)
  end


end
