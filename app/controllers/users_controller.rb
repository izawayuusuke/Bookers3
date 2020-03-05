class UsersController < ApplicationController
  def index
    @book = Book.new
  	@books = Book.all
  end

  def show
  	@book = Book.new
  	@books = Book.all
  end

  def create
  end

  def edit
    @book = Book.find(params[:id])
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
end
