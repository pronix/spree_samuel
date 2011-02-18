Given /^I have an admin account "([^\"]*)" with "([^\"]*)"$/ do |email, password|
  attributes = {
    :password => password,
    :password_confirmation => password,
    :email => email,
    :login => email
  }
  user = User.find_or_create_by_email(email)
  user.update_attributes(attributes)
  role = Role.find_or_create_by_name "admin"
  user.roles << role unless user.roles.include?(role)
end

Given /^I am logged in as admin "([^\"]*)" with "([^\"]*)"$/ do |email, password|
  #Logout and go to login
  Given 'I am not logged in'
  When 'I go to the admin page'
  Then 'I should be on the login page'

  #Create / edit admin and login with parametrs
  Given 'I have an admin account "admin@spree.com" with "password"'
  And 'I fill in "Email" with "admin@spree.com"'
  And 'I fill in "Password" with "password"'
  And 'I press "Log in"'
  And 'I should be on the admin page'
  And 'I should see "Logged in successfully"'
end

Then /^I should see in admin panel the following list of products:$/ do |table|
  table.hashes.each do |attr|
    @product = Product.find_by_name(attr["Name"])
    with_scope("tr#product_#{@product.id}") do
      attr.values.each{ |a| page.should have_selector("td", :text => a) }
    end
  end
end

Then /^I should not see in admin panel the following list of products:$/ do |table|
  table.hashes.each do |attr|
    with_scope("table.index") do
      attr.values.each{ |a| page.should_not have_selector("td", :text => a) }
    end
  end
end
