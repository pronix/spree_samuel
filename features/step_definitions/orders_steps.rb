Given /^the following orders exist:$/ do |table|
  table.hashes.each do |attrs|

    @user = User.find_by_email(attrs["user_email"])
    @order_hash = attrs.except("created_at").except("user_email")
    @order = Factory.create(:order, @order_hash.merge({ :user => @user, :state => @state, :completed_at => Time.now }))
    @order.created_at = Time.parse(attrs["created_at"]) if attrs.has_key?("created_at")
    @order.number = attrs["number"] if attrs.has_key?("number")
    @order.save!

  end
end
