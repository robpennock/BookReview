class Book < ActiveRecord::Base
	#allows for association between books and users
	#need this for controller create actions to work
	belongs_to :user
	#a little obtuse but think about it
	belongs_to :category
end
