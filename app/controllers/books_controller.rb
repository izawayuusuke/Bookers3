class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @new_book = Book.new
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
      @user = current_user
      @books = Book.all
      render "users/show"
  	end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path(current_user)
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    else
      render "books/edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_book
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
