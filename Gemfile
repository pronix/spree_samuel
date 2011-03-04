source 'http://rubygems.org'

gem 'bundler',               '~> 1.0.10'
gem 'rails',                 '3.0.4'
gem 'rack',                  '1.2.1'
gem 'pg',                    '0.10.1'

gem 'spree', '0.40.3'

gem "exception_notification_rails3", :git => "git://github.com/railsware/exception_notification.git", :require => 'exception_notifier'



# Deploy with Capistrano
 gem 'capistrano'
 gem 'capistrano-ext'

gem 'authorize_net', '1.5.2', :path => 'vendor/plugins/authorize-net-1.5.2'
# Spree extensons
gem "samuel", :require => "samuel", :path => "samuel"
gem "spree_social", :git => "git://github.com/spree/spree_social.git"
gem "prawn"
gem "spree_print_invoice", :path => "./spree-print-invoice"
gem "spree_qr_code", :require => "spree_qr_code", :path => "spree_qr_code"
gem "advanced_reporting", :require => "advanced_reporting", :path => "spree-advanced-reporting"
gem "spree_authorize_net_reports", :require => "spree_authorize_net_reports", :path => "spree_authorize_net_reports"

gem 'rqrcode', '0.3.3'
gem 'rmagick', '2.13.1'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:

group :development, :test, :cucumber do
  gem "faker"
  gem 'unicorn'
  gem "capybara",            "0.4.1.2"
  gem "rspec",               "2.5.0"
  gem "rspec-rails",         "2.5.0"
  gem "cucumber",            "0.10.0"
  gem "cucumber-rails",      "0.3.2"
  gem "factory_girl_rails",  "1.0.1"
  gem "launchy",             "0.3.7"
  gem "Selenium",            "1.1.14"
  gem 'email_spec',          "~> 1.1.1"
  gem 'database_cleaner'
  gem 'ruby-debug'
  gem 'mocha',               '0.9.12'
end
