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

  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(params[:action].to_sym, (object||Promotion)) : authorize!( :admin, Object)
  end

end
