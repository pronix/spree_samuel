module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /^the "([^\"]*)" tax category page$/i
      admin_tax_category_path(TaxCategory.find_by_name($1))
    when /^the edit "([^\"]*)" tax category page$/i
      edit_admin_tax_category_path(TaxCategory.find_by_name($1))

    when /^the "([^\"]*)" product page$/i
      admin_product_path(Product.find_by_name($1))
    when /^the edit "([^\"]*)" product page$/i
      edit_admin_product_path(Product.find_by_name($1))
    when /^the admin edit "([^\"]*)" ([^\"]*) page/
      obj_id, factory, klass = $1, $2.gsub(/\s/, "_").singularize
      klass = factory.camelcase.constantize
      obj = klass.send((klass.respond_to?(:name) ? :find_by_name : :find_by_id), obj_id )
      self.send(["edit", "admin",factory , "path"].join("_").to_sym, obj)

    when /^invoices list page$/
      '/account'

    when /^the edit (.+) addresses page/
      edit_addresses_path($1.to_s =~ /billing/ ? :bill : :ship)
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
