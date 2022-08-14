class Permcl < ActiveRecord::Base

  has_many :permissions
	accepts_nested_attributes_for :permissions
	

end
