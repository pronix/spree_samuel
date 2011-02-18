Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find_by_email(email).should be_nil
end

Then /^(\d+) users should exist$/ do |c|
  User.count.should == c.to_i
end

Then /^I should see login form$|^I am shown the user login page$/ do
  page.should have_css("form[action='/users/sign_in']")
end

Then /^I should be viewing seller dashboard$/ do
  Then %Q{I should see link "Overview"}
   And %Q{I should see link "Orders"}
   And %Q{I should see link "Products"}
   And %Q{I should see link "Reports"}
end
