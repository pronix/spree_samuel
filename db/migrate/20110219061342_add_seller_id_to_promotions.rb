class AddSellerIdToPromotions < ActiveRecord::Migration
  def self.up
    add_column :promotions, :seller_id, :integer
  end

  def self.down
    remove_column :promotions, :seller_id
  end
end
