Then /^the goods "([^\"]*)" must be removed$/ do |product_name|
  sleep(1)
  Product.find_by_name(product_name).send(:deleted?).should be_true
end

Given /^the following products exist:$/ do |table|
  table.hashes.each do |attributes|
    @taxon = Taxon.find_by_name(attributes["taxon"]) if attributes.has_key?("taxon")
    product_attributes = attributes.except("taxon").except("seller")
    product_attributes["seller"] = User.find_by_email(attributes["seller"]) if  attributes.has_key?("seller")
    product = Factory.create(:product, product_attributes.merge({ :taxons => [@taxon]}))
    if product_attributes.has_key?("created_at")
      product.created_at = Time.parse(product_attributes["created_at"])
      product.save
    end

  end
end


Given /^the following categories exist:$/ do |table|
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
