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

    end
  end
end
