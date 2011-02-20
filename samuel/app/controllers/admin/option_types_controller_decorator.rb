Admin::OptionTypesController.class_eval do

  private

  def authorize_admin
    current_user.try(:seller_and_not_admin?) ?  authorize_seller : authorize!( :admin, Object)
  end

  def authorize_seller
    authorize!(params[:action].to_sym, OptionType)
  end

end
