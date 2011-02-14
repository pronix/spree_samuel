Given /^there is next categories:$/ do |table|
  TaxCategory.delete_all
  table.hashes.each { |hash|
    Factory(:tax_category, hash)
  }
end

Then /^I should see the Delete link for "([^"]*)"$/ do |name|
  category = TaxCategory.find_by_name(name)
  within("tr#tax_category_#{category.id}") do
    Then 'I should see "Delete"'
  end
end

When /^I follow Delete link for "([^"]*)"$/ do |name|
  category = TaxCategory.find_by_name(name)
  within("tr#tax_category_#{category.id}") do
    click_link("Delete")
  end
end

Then /^I should see the deletion confirmation box for category$/ do
  within("div#popup_container") do
    Then 'I should see "Confirm Deletion"'
    Then 'I should see "Are you sure?"'
  end
end


