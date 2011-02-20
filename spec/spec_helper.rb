# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Zone.class_eval do
  def self.global
    find_by_name("GlobalZone") || Factory(:global_zone)
  end
end
Country.class_eval do
  def self.default
    find_by_id(Spree::Config[:default_country_id]) || Factory(:country)
  end
end

Product.class_eval do
  def taxon=(taxon_name)
    taxonomy = Taxonomy.find_or_create_by_name("Category")
    taxon = Taxon.find_or_create_by_name_and_taxonomy_id(taxon_name, taxonomy)
    self.taxons << taxon
  end
end
Taxonomy.create({:name => 'Categories'})
ShippingMethod.create(:name => "UPS Ground", :zone => Zone.global, :calculator => Calculator::FlatRate.new)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

#  require 'factory_girl'
#  # Find and load factory definitions
#  Factory.find_definitions

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end
