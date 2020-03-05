class BooksController < ApplicationController
  def index
  end

  def show
  end

  def create
	@book = Book.new(book_params)
	@book.user_id = current_user.id
  	if @book.save
  	  flash[:notice] = "You have created book successfully."
  	  redirect_to user_path(@book)
    else
      @books = Book.all
      render "users/show"
  	end
  end

  def edit
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
end
