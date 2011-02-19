# Seller permissions
#
class SellerAbility
  include CanCan::Ability
  def initialize(user)
    if user.has_role? 'seller'
      can :manage, Admin::OverviewController
      can :manage, Admin::ReportsController

      # ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      # Доступ к товарам
      can [ :index, :create, :new ],  Product
      can [ :read, :edit, :update, :destroy ],   Product do |product|
        product.seller == user
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
