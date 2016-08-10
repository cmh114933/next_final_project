class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.integer :position, default: 1
      t.boolean :in_jail
      t.integer :igc_game
      t.integer :reputation
      t.integer :job
      t.string :token
      t.timestamps null: false
    end
  end
end
