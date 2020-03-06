class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def create
	  @book = Book.new(book_params)
	  @book.user_id = current_user.id
  	if @book.save
  	  flash[:notice] = "You have created book successfully."
  	  redirect_to book_path(@book)
    else
      @books = Book.all
      render "users/show"
  	end
  end

  def edit
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
