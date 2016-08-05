class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :event
      t.timestamps null: false
    end
  end
end
