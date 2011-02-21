class Admin::TrackAccountsController < Admin::BaseController

  def index
  end

  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(:seller, self.class) : authorize!( :admin, Object)
  end

end
