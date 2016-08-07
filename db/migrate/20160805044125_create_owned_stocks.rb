class CreateOwnedStocks < ActiveRecord::Migration
  def change
    create_table :owned_stocks do |t|
      t.integer :price
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
