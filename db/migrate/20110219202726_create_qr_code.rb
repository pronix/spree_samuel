class CreateQrCode < ActiveRecord::Migration
  def self.up
    create_table :qr_codes do |t|
      t.string :code
      t.integer :line_item_id
      t.integer :count
      t.integer :used_count
      t.timestamps
    end
  end

  def self.down
    drop_table :qr_codes
  end
end
