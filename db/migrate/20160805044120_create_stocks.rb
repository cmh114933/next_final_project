class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.belongs_to :game
      t.string :company_name
      t.integer :price
      t.integer :quantity
      t.string :s_type
      t.timestamps null: false
    end
  end
end
