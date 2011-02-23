Given /^the following orders exist:$/ do |table|
  table.hashes.each do |attrs|

    @user = User.find_by_email(attrs["user_email"])

    @products = []
    attrs.has_key?("products") && attrs["products"].split(",").each do |product_attr|
      @product_name, @product_count = product_attr.to_s.split(':')
      @products << { :product => Product.find_by_name(@product_name.to_s.split), :count => @product_count.to_i }
    end
    @order_hash = attrs.except("created_at").except("user_email").except("products")

    @order = Factory.create(:order, @order_hash.merge({ :user => @user, :state => @state, :completed_at => Time.now }))
    if attrs.has_key?("created_at")
      @order.created_at = attrs["created_at"].to_s =~ /^lambda/ ? eval(attrs["created_at"]).call : Time.parse(attrs["created_at"])
    end

    unless @products.blank?
      @products.each do |product_attr|
        Factory.create(:line_item,
                :order => @order,
                :variant  => product_attr[:product].master,
                :quantity => product_attr[:count],
                :price    => product_attr[:product].master.price )
      end
      @order.update!
    end
    @order.number = attrs["number"] if attrs.has_key?("number")
    @order.save!
  end
end
