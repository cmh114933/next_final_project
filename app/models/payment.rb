class Payment < ActiveRecord::Base
	belongs_to :user
	has_many :pricing_plans
end
