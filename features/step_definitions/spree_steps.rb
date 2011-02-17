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
