class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :event
      t.string :event_type
      t.string :series
      t.integer :times_called, default: 0
      t.timestamps null: false
    end
  end
end
