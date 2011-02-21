class Admin::TrackAccountsController < Admin::BaseController

  def index
    @users =
      if current_user.try(:seller_and_not_admin?)
        current_user.customers
      else
        User
      end.joins(:orders).order(:"orders.created_at DESC").paginate(
                                                    :per_page => Spree::Config[:admin_products_per_page], :page => params[:page])

  end

  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(:seller, self.class) : authorize!( :admin, Object)
  end

end
