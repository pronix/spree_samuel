Then /^the goods "([^\"]*)" must be removed$/ do |product_name|
  sleep(1)
  Product.find_by_name(product_name).send(:deleted?).should be_true
end

Given /^the following products exist:$/ do |table|
  table.hashes.each do |attributes|
    taxon = Taxon.find_by_name(attributes["taxon"]) if attributes.has_key?("taxon")
    on_hand = attributes["on_hand"].to_i if attributes.has_key?("on_hand")

    product_attributes = attributes.except("taxon").except("seller").except("on_hand")
    product_attributes["seller"] = User.find_by_email(attributes["seller"]) if  attributes.has_key?("seller")
    product = Factory.create(:product, product_attributes.merge({ :taxons => [taxon]}))

    product.created_at = Time.parse(product_attributes["created_at"]) if product_attributes.has_key?("created_at")
    product.on_hand = on_hand if attributes.has_key?("on_hand")
    product.save if product.changed?


  end
end

Then /^I should see in admin panel the following inventory levels:$/ do |table|
  table.hashes.each do |r|
    @product = Product.find_by_name(r["Product"])
    with_scope("tr#product_#{@product.id}") do
      page.should have_css("td", :text => @product.name)
    end
    @variant = @product.variants_including_master.find_by_sku(r["Sku"])
    with_scope("tr#variant_#{@variant.id}") do
      page.should have_css("td", :value => r["Variant"])
      page.should have_css("input", :value => r["Sku"])
      page.should have_css("input", :value => r["On hand"])
    end

  end
end
