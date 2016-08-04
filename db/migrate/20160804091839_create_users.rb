class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :token
      t.integer :IGC_total
      t.integer :IGC_base

      t.timestamps null: false
    end
  end
end
