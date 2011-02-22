CheckoutController.class_eval do

  private

  # Default bill and ship address
  #
  def before_address

    @order.bill_address , @order.ship_address = current_user.bill_address.clone, current_user.ship_address.clone
    @order.bill_address ||= Address.new(:country => default_country)
    @order.ship_address ||= Address.new(:country => default_country)
  end


end
