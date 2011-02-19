Admin::PromotionRulesController.class_eval do
    def authorize_admin
    if current_user && current_user.has_role?(:seller) && !current_user.has_role?(:admin)
      authorize!(params[:action].to_sym, (object||PromotionRule))
    else
      authorize! :admin, Object
    end
  end

end
