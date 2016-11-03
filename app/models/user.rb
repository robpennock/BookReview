class User < ActiveRecord::Base
	#allows for association between books and users
	#need this for controller create actions to work
	has_many :books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
