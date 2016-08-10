class CreateOwnedStocks < ActiveRecord::Migration
  def change
    create_table :owned_stocks do |t|
      t.belongs_to :player
      t.string :company_name
      t.integer :price
      t.integer :quantity
      t.string :s_type
      t.timestamps null: false
    end
  end
end
