class PermclAction < ActiveRecord::Base

  has_many :permissions
	accepts_nested_attributes_for :permissions

	def action_value
	end


end
