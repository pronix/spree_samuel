Then /^the goods "([^\"]*)" must be removed$/ do |product_name|
  sleep(1)
  Product.find_by_name(product_name).send(:deleted?).should be_true
end
