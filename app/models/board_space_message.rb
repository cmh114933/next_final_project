class BoardSpaceMessage < ActiveRecord::Base
	belongs_to :board_space
	belongs_to :message
end
