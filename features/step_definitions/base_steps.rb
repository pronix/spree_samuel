Given /^there is next (.+):$/ do |factory, table|
  factory, model = get_factory_and_model(factory)
  model.delete_all
  table.hashes.each { |hash|
    Factory(factory.to_sym, hash)
  }
end

Then /^I should see the (.+) Delete link for "([^"]*)"(?: as (.+))?$/ do |factory, value, search|
  factory, model = get_factory_and_model(factory)
  object = model.send("find_by_#{search || "name"}", value)
  within("tr##{factory}_#{object.id}") do
    Then 'I should see "Delete"'
  end
end

When /^I follow (.+) Delete link for "([^"]*)"(?: as (.+))?$/ do |factory, value, search|
  factory, model = get_factory_and_model(factory)
  object = model.send("find_by_#{search || "name"}", value)
  within("tr##{factory}_#{object.id}") do
    click_link("Delete")
  end
end

Then /^(.+) "([^"]*)"(?: as (.+))? should be deleted$/ do |factory, value, search|
  factory, model = get_factory_and_model(factory)
  model.send("find_by_#{search || "name"}", value).should be_nil
end



Then /^I should see the deletion confirmation box$/ do
  within("div#popup_container") do
    Then 'I should see "Confirm Deletion"'
    Then 'I should see "Are you sure?"'
  end
end

def get_factory_and_model(pluarize_string)
  factory = pluarize_string.gsub(/\s/, "_").singularize
  model = factory.camelcase.constantize
  [factory, model]
end