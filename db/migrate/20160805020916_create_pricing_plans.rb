class CreatePricingPlans < ActiveRecord::Migration
  def change
    create_table :pricing_plans do |t|
      t.integer :price_of_coin
      t.integer :value_of_coin

      t.timestamps null: false
    end
  end
end
