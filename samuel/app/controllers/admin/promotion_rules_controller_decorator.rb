Admin::PromotionRulesController.class_eval do

  private

  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(params[:action].to_sym, (object||PromotionRule)) :
      authorize!( :admin, Object)
  end

end
