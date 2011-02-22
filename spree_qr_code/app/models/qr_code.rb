require 'qrimage'
class QrCode < ActiveRecord::Base
  belongs_to :line_item
  before_create :set_qr_code

  validates_uniqueness_of :line_item_id

  def self.create_for_order(order)
    #Create for each product in order
    order.line_items.each do |item|
      if item.product.generate_qr_code
        self.create(
          :line_item => item,
          :used_count => 0,
          :count => item.quantity
        )
      end
    end
  end

  def image(size = 2)
    QRImage.create_qr(self.code, :size => size)
  end
  
  protected
    def set_qr_code
      self.code = ActiveSupport::SecureRandom.hex(7)
    end
  
  
end