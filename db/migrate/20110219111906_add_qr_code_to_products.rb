class AddQrCodeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :qr_code, :string
  end

  def self.down
    remove_column :products, :qr_code
  end
end
