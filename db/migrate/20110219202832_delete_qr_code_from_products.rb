class DeleteQrCodeFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :qr_code
  end

  def self.down
    add_column :products, :qr_code, :string
  end
end
