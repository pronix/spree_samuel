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

  # scope :by_seller, lambda{|vendor_id| where(:seller_id => vendor_id)}
end
