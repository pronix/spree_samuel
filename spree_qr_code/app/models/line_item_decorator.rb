LineItem.class_eval do
  has_one :qr_code, :dependent => :destroy
end
