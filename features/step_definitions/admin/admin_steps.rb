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
  Given 'I go to the home page'
  And 'I am logged out'
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

Then /^I should see in admin panel the following list of promotions:$/ do |table|
  table.hashes.each do |attr|
    @promotion = Promotion.find_by_name(attr["Name"])
    with_scope("tr#promotion_#{@promotion.id}") do
      attr.except("Name").values.each{ |a| page.should have_selector("td", :text => a) }
    end
  end

end

Then /^I should not see in admin panel the following list of promotions:$/ do |table|
  table.hashes.each do |attr|
    with_scope("table.index") do
      attr.values.each{ |a| page.should_not have_selector("td", :text => a) }
    end
  end

end


Then /^I should see in admin panel the following list of "([^\"]*)":$/ do |collection,  table|
  klass = collection.classify.constantize
  table.hashes.each_with_index do |attr, i|
    @obj = klass.send "find_by_#{attr.keys.first.downcase}", attr[attr.keys.first]
    with_scope("table.index") do
      attr.except("id_name").values.each do |a| 
        page.should have_selector("td")
        page.should have_content(a)
      end
    end
  end

end

When /^I fill in "([^\"]*)" with "([^\"]*)" for variant "([^\"]*)"$/ do |value, field, product_name_and_variant_sku|
  @product_name, @variant_sku = product_name_and_variant_sku.split(':')
  @product = Product.find_by_name(@product_name)
  @variant = @product.variants_including_master.find_by_sku(@variant_sku)
  fill_in("variants[#{@variant.id}][#{field}]", :with => value)
end


Then /^I should see the following list of users in track accounts:$/ do |table|
  table.hashes.each do |attrs|
    @user = User.find_by_email(attrs["user"])
    with_scope("tr#user_#{@user.id}") do
      attrs.except("user").values.each{ |a| page.should have_selector("td", :text => a) }
    end
  end

end

When /^I click "([^\"]*)" within track accounts for "([^\"]*)"$/ do |link, user_email|
  with_scope("tr#user_#{User.find_by_email(user_email).try(:id)}>td:last") do
    click_link(link)
  end
end

Then /^I should see the following list of orders for "([^\"]*)":$/ do |user_email, table|
  @user = User.find_by_email(user_email)
  table.hashes.each do |attrs|
    @order =  Order.find_by_number(attrs["number"])
    with_scope("tr#order_#{@order.id}") do
      attrs.values.each{ |a| page.should have_selector("td", :text => a) }
    end
  end
end
