class Message < ActiveRecord::Base
	has_many :board_spaces, through: :board_space_messages
	has_many :board_space_messages
end
