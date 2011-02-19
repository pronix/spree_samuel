Product.class_eval do
  belongs_to :seller, :class_name => "User"

  before_create :set_qr_code

  def qr_code_image
    QRImage.create_qr(self.qr_code, :size => 2, :level => 'h')
  end

  protected
    def set_qr_code
      self.qr_code = ActiveSupport::SecureRandom.hex(8)
    end
  
end
