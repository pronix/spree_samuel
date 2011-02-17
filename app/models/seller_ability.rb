# Seller permissions
#
class SellerAbility
  include CanCan::Ability
  def initialize(user)
    if user.has_role? 'seller'
      can :manage, Admin::OverviewController
    end
  end
end
