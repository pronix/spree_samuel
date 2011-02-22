class Admin::InventoryController < Admin::BaseController

  def index
    @inventory = current_user.products.active.paginate(:order => 'products.name',
                                                       :per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
  end

  def update
    (params[:variants]||[]).map { |variant_id, attrs| update_variant(variant_id, attrs) }
    redirect_to admin_inventory_path, :notice => "Successfully Updated."
  end

  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(:seller, self.class) : authorize!( :admin, Object)
  end

  def update_variant(variant_id, attrs)
    if @variant = find_variant(variant_id)
      @variant.sku, @variant.on_hand = attrs[:sku], attrs[:on_hand]
      @variant.save if @variant.changed?
    end
  end

  def find_variant(variant_id)
    ( current_user.try(:seller_and_not_admin?) ?
       Variant.includes(:product).where(:id => variant_id, :"products.seller_id" => current_user.id) :
        Variant.where(:id => variant_id)
     ).first
  end
end
