class AddSellerIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :seller_id, :products
    add_index  :products, :seller_id
  end

  def self.down
    remove_index  :products, :seller_id
    remove_column :products, :seller_id
  end
end
