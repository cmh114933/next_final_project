class CreateDices < ActiveRecord::Migration
  def change
    create_table :dices do |t|
      t.integer :roll
      t.timestamps null: false
    end
  end
end
