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
      can :new, Product
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



    end
  end
end
