Factory.define(:address) do |record|
  record.firstname  { Faker::Name.first_name }
  record.lastname   { Faker::Name.last_name }
  record.address1   "W 23rd Street"
  record.address2   { Faker::Address.secondary_address }
  record.city       "New York"
  record.zipcode    "10010"
  record.phone      { Faker::PhoneNumber.phone_number }
  record.state_name  "New York"
  record.alternative_phone { Faker::PhoneNumber.phone_number }

  # record.active true

  # associations:
  record.country {
    Country.find_by_id(Spree::Config[:default_country_id]) || Country.first || Factory(:country)
  }
  record.state { Factory(:state)}
end
