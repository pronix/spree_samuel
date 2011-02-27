require 'spree_core'
require 'samuel_hooks'

module Samuel
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      PaymentMethod.class_eval do
        has_many :payments
        has_many :orders, :through => :payments
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
