class CreateBoardSpaceMessages < ActiveRecord::Migration
  def change
    create_table :board_space_messages do |t|
      t.belongs_to :board_space
      t.belongs_to :message
      t.timestamps null: false
    end
  end
end
