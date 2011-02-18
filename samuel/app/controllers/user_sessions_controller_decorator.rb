UserSessionsController.class_eval do
  def create
    authenticate_user!

    if user_signed_in?
      respond_to do |format|
        format.html {
          flash[:notice] = t("logged_in_succesfully")
          redirect_back_or_default(current_user.has_role?(:seller) ? admin_path : products_path)
        }
        format.js {
          user = resource.record
          render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
        }
      end
    end
  end

end
