User.class_eval do
  has_many :products,   :foreign_key => "seller_id"
  has_many :promotions, :foreign_key => "seller_id"
  def seller_and_not_admin?
    has_role?(:seller) && !has_role?(:admin)
  end
end
