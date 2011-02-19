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
      can :index,  Product
      can :create, Product
      can :new,    Product
      can :read,   Product do |product|
        product.seller == user
      end
      can :edit,   Product do |product|
        product.seller == user
      end
      can :update,   Product do |product|
        product.seller == user
      end
      can :destroy,   Product do |product|
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
      can :index,  Promotion
      can :create, Promotion
      can :new,    Promotion
      can :read,   Promotion do |promotion|
        promotion.seller == user
      end
      can :edit,  Promotion do |promotion|
        promotion.seller == user
      end
      can :update,   Promotion do |promotion|
        promotion.seller == user
      end
      can :destroy,   Promotion do |promotion|
        promotion.seller == user
      end

      can :index,  PromotionRule
      can :create, PromotionRule
      can :new,    PromotionRule
      can :read,   PromotionRule do |promotion_rule|
        promotion_rule.promotion.seller == user
      end
      can :edit,  PromotionRule do |promotion_rule|
        promotion_rule.promotion.seller == user
      end
      can :update, PromotionRule do |promotion_rule|
        promotion_rule.promotion.seller == user
      end
      can :destroy, PromotionRule do |promotion_rule|
        promotion_rule.promotion.seller == user
      end

      can :index,  Taxonomy
      can :create, Taxonomy
      can :new,    Taxonomy
      can :read,   Taxonomy
      can :edit,   Taxonomy

      can :index,  Taxon
      can :create, Taxon
      can :new,    Taxon
      can :read,   Taxon

    end
  end
end
