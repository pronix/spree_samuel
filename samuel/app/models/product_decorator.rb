Product.class_eval do
  belongs_to :seller, :class_name => "User"

  # Поиск по названию товара и по sku
  #
  scope :search_by_name_or_sku, lambda{ |q|
    match_keyword = ::ActiveRecord::Base.connection.adapter_name == "PostgreSQL" ? "ILIKE" : "LIKE"
    includes(:variants_including_master).
      where("products.name #{match_keyword} :name or variants.sku #{match_keyword} :name ", :name => "%#{q}%")
  }

  before_create :set_qr_code

  def qr_code_image
    QRImage.create_qr(self.qr_code, :size => 2, :level => 'h')
  end

  protected
  def set_qr_code
    self.qr_code = ActiveSupport::SecureRandom.hex(8)
  end

end
