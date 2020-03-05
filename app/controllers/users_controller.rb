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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image_id)
  end
end
