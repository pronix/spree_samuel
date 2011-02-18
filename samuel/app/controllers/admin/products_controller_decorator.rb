Admin::ProductsController.class_eval do
  belongs_to :current_seller

  protected
  def parent_object
    current_user
  end

  private

  # def build_object
  #   @object = Product.new object_params
  #   @object.seller = current_user
  # end

  def authorize_admin
    if current_user && current_user.has_role?(:seller) && !current_user.has_role?(:admin)
      if [:index, :new].include?(params[:action].to_sym)
        authorize!(params[:action].to_sym, Product)
      else
        load_data
        authorize!(params[:action].to_sym, @product)
      end

    else
      authorize! :admin, Object
    end
  end

end
