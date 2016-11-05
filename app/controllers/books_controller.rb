#remember that controller names are plural
#define controller actions here
class BooksController < ApplicationController

	before_action :find_book, only: [:show, :edit, :update, :destroy]

	def index
		if params[:category].blank?
			#instance variable containing all books for view access
			#books ordered by decending creation date
			@books = Book.all.order("created_at DESC")
		else
			#get id of category matching selected category
			@category_id = Category.find_by(name: params[:category]).id
			#display books that match category_id
			@books = Book.where(:category_id => @category_id).order("created_at DESC")
		end
	end
	#show is for showing individual books
	def show
		#show now run by find_book and before_action
		#keeps code dry
	end
	def new
		#application instance variable
		#used in the views
		#used to simply be @book=Book.new

		#builds books out of the current user, needs model assoiations to work
		@book = current_user.books.build
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	#create is simply new method with parameters
	#does not have its own view, simply redirects
	#uses e
	def create
		@book = current_user.books.build(book_params)
		#to associate book with category id
		@book.category_id = params[:category_id]
		if @book.save 
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		#needed to reference the action to the view

		#need access to categories in books controller
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def update
		@categories = Category.all.map{ |c| [c.name, c.id] }
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
			params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
		end
		def find_book
			@book = Book.find(params[:id])
		end
	#private does not need end statment
end
