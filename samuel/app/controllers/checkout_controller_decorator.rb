CheckoutController.class_eval do

  private

  # Default bill and ship address
  #
  def before_address
    @order.bill_address ||= current_user.try(:bill_address).try(:clone) || Address.new(:country => default_country)
    @order.ship_address ||= current_user.try(:ship_address).try(:clone) || Address.new(:country => default_country)
  end


end
