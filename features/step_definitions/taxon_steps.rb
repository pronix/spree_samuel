Given /^the following categories exist:$/ do |table|
  Taxonomy.destroy_all
  data = table.raw
  taxonomy_category = Factory.create(:taxonomy,{ :name => "Categories"})
  taxon_category = Taxon.find_by_name("Categories") ||
    Factory.create(:root_taxon, { :name =>"Categories", :taxonomy =>taxonomy_category } )

  data.each do |taxons|
    @root_taxon = taxon_category
    taxons.each do |taxon|
      @root_taxon = Taxon.find_by_name(taxon) ||
        Factory.create(:taxon,{ :parent => @root_taxon, :name => taxon, :taxonomy =>taxonomy_category })
    end
  end
end

Given /^the following taxonomies exist:$/ do |table|
  table.hashes.each do |attrs|
    Taxonomy.find_by_name(attrs["name"]) || Factory.create(:taxonomy,attrs)
  end
end

When /^I click right button on "([^\"]*)" element tree$/ do |taxon_name|
  @taxon = Taxon.find_by_name(taxon_name)
  page.driver.browser.execute_script %Q{$('li##{@taxon.id}>a').trigger('contextmenu.jstree'); }
end
Then /^I should view context menu for seller$/ do
  with_scope("#vakata-contextmenu") do
    Then %Q(I should see link "Create")
  end
end
