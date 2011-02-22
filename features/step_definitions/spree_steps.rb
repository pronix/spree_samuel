When /^I confirm popup ok/ do
  page.driver.browser.execute_script %Q{$('#popup_ok').trigger('click'); }
end

When /^I confirm that all$/ do
  page.evaluate_script('window.confirm = function() { return true; }')
end

When /^(?:|I )return to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I should have (\d+) order$/ do |c|
  User.find_by_email('email@person.com').orders.count.should == c.to_i
end

Then /^I should see error messages$/ do
  page.should have_css("#errorExplanation")
end

Then /^I should see "([^\"]*)" translation$/ do |key|
  page.should have_content(I18n.t(key))
end

Then /^I debug$/ do
  require 'ruby-debug'; debugger
end

Then /^I should see link "([^\"]*)"$/ do |link_text|
  page.should have_selector("a", :text => link_text)
end

Then /^I not should see link "([^\"]*)"$/ do |link_text|
  page.should_not have_selector("a", :text => link_text)
end

Given /^load default data$/ do
  Fixtures.reset_cache
  Dir.glob(Rails.root + 'spec/data/default/*.{yml,csv,rb}').each do |file|
    Fixtures.create_fixtures('spec/data/default', File.basename(file, '.*'))
  end
end
