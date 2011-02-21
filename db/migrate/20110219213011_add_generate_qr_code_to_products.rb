class AddGenerateQrCodeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :generate_qr_code, :boolean, :default => true
  end

  def self.down
    remove_column :products, :generate_qr_code
  end
end
