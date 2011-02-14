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