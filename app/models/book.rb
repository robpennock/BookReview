class Book < ActiveRecord::Base
	#allows for association between books and users
	#need this for controller create actions to work
	belongs_to :user
	#a little obtuse but think about it
	belongs_to :category

	#:book_img originally :avatar
	has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png" 
	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

	#original paperclip stuff
	#has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	#validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
