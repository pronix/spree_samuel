Admin::ProductsController.class_eval do

  private

  def seller_products
    current_user.has_role?(:admin) ? Product : current_user.products
  end

  # Создание товара с учетом продовца
  #
  def build_object
    @object ||= current_user.products.build(object_params)
  end

  # Вывод товаров с учетом ид продовца или вывод всех если пользователь админ
  #
  def collection
    return @collection if @collection.present?
    scopes = ['group_by_products_id']

    unless request.xhr?
      # Note: the SL scopes are on/off switches, so we need to select "not_deleted" explicitly if the switch is off
      # QUERY - better as named scope or as SL scope?
      if params[:search].nil? || params[:search][:deleted_at_not_null].blank?
        scopes << 'not_deleted'
      end
      scopes << "seller_id_equals(#{current_user.id})" if current_user.has_role?(:seller) && !current_user.has_role?(:admin)

      @search =  end_of_association_chain.searchlogic(params[:search] ? params[:search].except(:deleted_at_not_null) : nil)
      @search.order ||= "ascend_by_name"

      @collection = @search.do_search.instance_eval(scopes.join(".")).paginate(:include   => {:variants => [:images, :option_values]},
                                                                               :per_page  => Spree::Config[:admin_products_per_page],
                                                                               :page      => params[:page])
    else
      includes = [{:variants => [:images,  {:option_values => :option_type}]}, :master, :images]
      result_limit = params[:limit] || 10
      @collection =
        [ seller_products.where(["name LIKE ?", "%#{params[:q]}%"]).includes(includes).limit(result_limit),
          seller_products.where(["variants.sku LIKE ?", "%#{params[:q]}%"]).includes(:variants_including_master).limit(result_limit)
        ].flatten.uniq
    end

  end


  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(params[:action].to_sym, (object||Product)) : authorize!( :admin, Object)
  end

end
