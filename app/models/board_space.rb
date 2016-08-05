class BoardSpace < ActiveRecord::Base
	has_many :messages, through: :board_space_messages 
	has_many :board_space_messages
end
