Then /^I should see the product Delete link for "([^"]*)"$/ do |name|
  product = Product.find_by_name(name)
  within("tr#product_#{product.id}") do
    Then 'I should see "Delete"'
  end
end

When /^I follow product Delete link for "([^"]*)"$/ do |name|
  product = Product.find_by_name(name)
  within("tr#product_#{product.id}") do
    click_link("Delete")
  end
end

Then /^I should see the deletion confirmation box for product$/ do
  within("div#popup_container") do
    Then 'I should see "Confirm Deletion"'
    Then 'I should see "Are you sure?"'
  end
end


