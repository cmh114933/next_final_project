class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :transaction_id
      t.integer :pricing_plan_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
