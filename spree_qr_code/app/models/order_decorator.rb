Order.class_eval do
  state_machine :initial => 'cart', :use_transactions => false do
    after_transition :to => 'complete', :do => :generate_qr_codes
  end

  protected
    def generate_qr_codes
      QrCode.create_for_order(self)
    end
end
