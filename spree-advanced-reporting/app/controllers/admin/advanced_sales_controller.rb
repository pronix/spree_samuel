class Admin::AdvancedSalesController < Admin::BaseController
  before_filter :load_data

  # User sales
  #
  def users
  end

  # Seller sales
  #
  def vendors
    render :users
  end

  # Product sales
  #
  def products

  end

  # Taxon sales (categories)
  #
  def taxons
  end

  # Payment Method sales
  #
  def payment_methods

  end

  # Coupon sales
  #
  def coupons

  end

  private

  def object(params_action = params[:action])
    @object ||= case params_action.to_s
                when /users|vendors/   then User.find(params[:id])
                when /products/        then Product.find_by_permalink(params[:id])
                when /taxons/          then Taxon.find(params[:id])
                when /payment_methods/ then PaymentMethod.available.find{|x| x.id == params[:id].to_i}
                when /coupons/         then Promotion.find(params[:id])
                end
    @object
  end

  def load_data(params_action = params[:action])
    prepare_params
    case params_action.to_s
    when /vendors/ then load_data_for_vendors
    when /users|products|taxons|payment_methods|coupons/
      send :"load_data_for_#{params_action.to_s}"
    end
  end

  def load_data_for_users
    @search = object.orders.searchlogic(params[:search])
    @data = @search.do_search
  end

  def load_data_for_vendors
    @search = object.seller_orders.searchlogic(params[:search])
    @data = @search.do_search
  end

  def prepare_params

    params[:search] = {} unless params[:search]
    params[:search][:order] ||= "descend_by_created_at"

    params[:search][:created_at_greater_than] =
      if params[:search][:created_at_greater_than].blank?
        Time.zone.now.beginning_of_month
      else
        Time.zone.parse(params[:search][:created_at_greater_than]).beginning_of_day rescue Time.zone.now.beginning_of_month
      end

    if params[:search] && !params[:search][:created_at_less_than].blank?
      params[:search][:created_at_less_than] = Time.zone.parse(params[:search][:created_at_less_than]).end_of_day rescue ""
    end

  end
end
