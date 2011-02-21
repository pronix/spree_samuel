Variant.class_eval do
  delegate :seller, :to => :product
end
