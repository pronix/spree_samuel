User.class_eval do
  has_many :products,   :foreign_key => "seller_id"
  has_many :promotions, :foreign_key => "seller_id"
end
