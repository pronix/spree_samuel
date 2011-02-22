Admin::TaxonomiesController.class_eval do

  private

  # Редактирование продавцом запрещено
  #
  def authorize_admin
    (current_user.try(:seller_and_not_admin?) && params[:action].to_sym != :update) ?
      authorize!(params[:action].to_sym, (object||Taxonomy)) :
        authorize!( :admin, Object)
  end
end
