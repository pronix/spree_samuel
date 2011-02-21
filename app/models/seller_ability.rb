# Seller permissions
#
class SellerAbility
  include CanCan::Ability
  def initialize(user)
    if user.has_role? 'seller'
      can :manage, Admin::OverviewController
      can :manage, Admin::ReportsController
      can :manage, Admin::InventoryController
      can :manage, Admin::TrackAccountsController

      # ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      # Доступ к товарам
      can [ :index, :create, :new ],  Product
      can [ :read, :edit, :update, :destroy ],   Product do |product|
        product.seller == user
      end
      can [ :index, :create, :new ],  Variant
      can [ :read, :edit, :update, :destroy ], Variant do |variant|
        variant.product.seller == user
      end

      can :manage, OptionType

      # Изображения для товаров
      #
      can [ :index, :new, :read, :create ], Image
      can [ :edit, :update, :destroy     ], Image do |image|
        image.viewable.respond_to?(:seller) ? image.viewable.seller == user : true
      end

      # ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      # Доступ к заказам
      can :index,  Order
      cannot :create, Order
      can :show,   Order do |order|
        order.products.map(&:seller_id).include?(user.id)
      end

      # ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      # купоны
      can [ :index , :create, :new],  Promotion
      can [ :read, :edit, :update, :destroy ],   Promotion do |promotion|
        promotion.seller == user
      end


      can [ :index, :create ],  PromotionRule
      can [ :read,:edit,:update, :destroy ],   PromotionRule do |promotion_rule|
        promotion_rule.promotion.seller == user
      end

      # ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      # категории товаров(таксоны)
      can [ :read, :create, :index, :edit, :get_children], Taxonomy
      cannot :destroy, Taxonomy

      can    [ :read, :create ],    Taxon
      cannot [ :update, :destroy ], Taxon


    end
  end
end
