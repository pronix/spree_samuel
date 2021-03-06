Given /^I am not logged in$/ do
  visit "/logout"
end

Given /^I am logged out$/ do
  begin
    click_link("Logout")
  rescue Capybara::ElementNotFound
  end
end

Then /^I should be logged in$/ do
  page.should_not have_content("Log In")
  page.should have_content("Logout")
end

Then /^I should be logged out$/ do
  page.should have_content("Log in")
end

# Given /^I am signed up as "(.+)\/(.+)"$/ do |email, password|

#   Factory(:user,
#           :email => email, :password => password, :password_confirmation => password )
# end

Given /^I am signed up as "([^\"]*)"(?: with roles "([^\"]*)")?$/ do |email_password, roles|
  email, password = email_password.split('/')
  Factory(:user,
          :email => email, :password => password, :password_confirmation => password, :bill_address => Factory(:address), :ship_address => Factory(:address),
          :roles => (roles||"").split(",").map{ |x| Factory("#{x}_role")} )
end

Given /^I have an admin account of "(.+)\/(.+)"$/ do |email, password|
  Factory(:admin_user,  :email => email, :password => password, :password_confirmation => password)
end

Given /^the following users exist:$/ do |table|
  table.hashes.each do |attr|
    Factory(:user,
            :email => attr["email"], :password => attr["password"], :password_confirmation => attr["password"],
            :roles => (attr["roles"]||[]).split(",").map{ |x| Factory("#{x}_role") unless x.blank? } )
  end
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the login page"}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Log in"}
end

