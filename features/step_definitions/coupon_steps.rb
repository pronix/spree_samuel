Given /^the following promotions exist:$/ do |table|
  table.hashes.each do |attributes|
    promotion_attributes = attributes.except("taxon").except("seller")
   promotion_attributes["seller"] = User.find_by_email(attributes["seller"]) if  attributes.has_key?("seller")
    Factory(:promotion, promotion_attributes)
  end
end
