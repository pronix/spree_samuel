# Исключаем из процесса оформления заказа, шаг "способ доставки"(deliver)
#
Order.state_machines[:state] = StateMachine::Machine.new(Order, :initial => 'cart', :use_transactions => false) do
  event :next do
    transition :from => 'cart', :to => 'address'
    transition :from => 'address', :to => 'payment'
    transition :from => 'confirm', :to => 'complete'
    # note: some payment methods will not support a confirm step
    transition :from => 'payment', :to => 'confirm', :if => Proc.new { Gateway.current and Gateway.current.payment_profiles_supported? }
    transition :from => 'payment', :to => 'complete'
  end

  event :cancel do
    transition :to => 'canceled', :if => :allow_cancel?
  end
  event :return do
    transition :to => 'returned', :from => 'awaiting_return'
  end
  event :resume do
    transition :to => 'resumed', :from => 'canceled', :if => :allow_resume?
  end
  event :authorize_return do
    transition :to => 'awaiting_return'
  end

  before_transition :to => 'complete' do |order|
    begin
      order.process_payments!
    rescue Spree::GatewayError
      if Spree::Config[:allow_checkout_on_gateway_error]
        true
      else
        false
      end
    end
  end

  after_transition :to => 'complete', :do => :finalize!
  # after_transition :to => 'payment', :do => :create_shipment!
  after_transition :to => 'canceled', :do => :after_cancel


end

Order.class_eval do

  scope :by_seller, lambda{|vendor_id| joins(:line_items => {:variant => :product}).where(:"products.seller_id" => vendor_id) }

  state_machine :initial => 'cart', :use_transactions => false do
    after_transition :from => 'address', :do => :clone_address_to_user
  end

  # Store bill and ship address to user, if user exits
  #
  def clone_address_to_user
    if user.present?
      user.build_bill_address(bill_address.clone.attributes) if user.bill_address.blank? && bill_address.present?
      user.build_ship_address(ship_address.clone.attributes) if user.ship_address.blank? && ship_address.present?
      user.save
    end
  end

end
