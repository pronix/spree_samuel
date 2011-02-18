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

Given /^I am signed up as "(.+)\/(.+)"(?: with roles "([^\"]*)")$/ do |email, password, roles|
  Factory(:user,
          :email => email, :password => password, :password_confirmation => password,
          :roles => roles.split(",").map{ |x| Factory("#{x}_role")} )
end

Given /^I have an admin account of "(.+)\/(.+)"$/ do |email, password|
  Factory(:admin_user,  :email => email, :password => password, :password_confirmation => password)
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the login page"}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Log in"}
end

