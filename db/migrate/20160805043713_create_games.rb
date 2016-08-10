class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :number_of_turns, default: 0
      t.integer :current_player_id
      t.string :special_msg
      t.string :status
      t.string :user_prompt_question, default:""
      t.string :user_prompt_type , default: ""
      t.string :events, array:true, default:[]
      t.timestamps null: false
    end
  end
end
