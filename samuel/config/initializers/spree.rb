if Spree::Config.instance
  Spree::Config.set(:allow_ssl_in_production => false)
end
