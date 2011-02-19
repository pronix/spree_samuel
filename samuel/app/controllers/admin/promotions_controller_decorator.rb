Admin::PromotionsController.class_eval do

  private

  def collection
    @colletion ||= current_user.has_role?(:admin) ? Promotion.all : current_user.promotions
  end

  def build_object
    @object ||=
      if current_user.has_role?(:admin)
        end_of_association_chain.send parent? ? :build : :new, object_params
      else
        current_user.promotions.build object_params
      end

    @object.calculator = params[:promotion][:calculator_type].constantize.new if params[:promotion]
  end


  def authorize_admin
    if current_user && current_user.has_role?(:seller) && !current_user.has_role?(:admin)
      authorize!(params[:action].to_sym, (object||PromotionRule))
    else
      authorize! :admin, Object
    end
  end

end
