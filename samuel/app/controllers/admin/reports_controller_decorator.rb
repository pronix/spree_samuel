Admin::ReportsController.class_eval do

  private
  def authorize_admin
    if current_user && current_user.has_role?(:seller) && !current_user.has_role?(:admin)
      authorize! :seller, self.class
    else
      authorize! :admin, Object
    end
  end


end
