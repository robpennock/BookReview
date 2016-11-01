#remember that controller names are plural
#define controller actions here
class BooksController < ApplicationController

	before_action :find_book, only: [:show, :edit, :update, :destroy]

	def index
		#instance variable containing all books for view access
		#books ordered by decending creation date
		@books = Book.all.order("created_at DESC")
	end
	#show is for showing individual books
	def show
		#show now run by find_book and before_action
		#keeps code dry
	end
	def new
		#application instance variable
		#used in the views
		@book=Book.new
	end
	#create is simply new method with parameters
	#does not have its own view, simply redirects
	#uses e
	def create
		@book=Book.new(book_params)
		if @book.save 
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to root_path
	end

	private
		#private since method will be used for updating
		def book_params
			params.require(:book).permit(:title, :description, :author)
		end
		def find_book
			@book = Book.find(params[:id])
		end
	#private does not need end statment
end
