User.class_eval do
  has_many :products, :foreign_key => "seller_id"
end
