Order.class_eval do
  def finalize!
    generate_qr_codes
    update_attribute(:completed_at, Time.now)
    self.out_of_stock_items = InventoryUnit.assign_opening_inventory(self)
    # lock any optional adjustments (coupon promotions, etc.)
    adjustments.optional.each { |adjustment| adjustment.update_attribute("locked", true) }
    OrderMailer.confirm_email(self).deliver
  end

  protected
    def generate_qr_codes
      QrCode.create_for_order(self)
    end
end
