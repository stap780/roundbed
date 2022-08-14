class Permission < ActiveRecord::Base

	belongs_to :user
	belongs_to :permcl
	belongs_to :permcl_action
	

end
