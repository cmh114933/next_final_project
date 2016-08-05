class CreateBoardSpaces < ActiveRecord::Migration
  def change
    create_table :board_spaces do |t|
   	  t.integer :position
      t.timestamps null: false
    end
  end
end
