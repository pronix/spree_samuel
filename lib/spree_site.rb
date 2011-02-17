module SpreeSite
  class Engine < Rails::Engine
    def self.activate
      Ability.register_ability(SellerAbility)
    end
    config.to_prepare &method(:activate).to_proc
  end
end
