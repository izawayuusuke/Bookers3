class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :ranking_books, except: [:show]

  def index
    @book = Book.new
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    if params[:sort]
      @books = Book.where(user_id: @user.id).order(sort_column + ' ' + sort_direction).page(params[:page])
    else
      @books = @user.books.page(params[:page])
    end

    @ranking_books = Book.my_rank(current_user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to @user
    else
      render "edit"
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
  end

  def followers
    @titlt = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
  end

  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]
    if @user_or_book == "0"
      @users = User.search(params[:search], @user_or_book, @how_search)
    else
      @books = Book.search(params[:search], @user_or_book, @how_search)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def address_params
    params.require(:user).permit(:postal_code, :prefecture_name, :address_city, :address_street, :address_building)
  end
end

# class Users::RegistrationController < Devise::RegistrationController
#   def create
#     respond_to do |format|
#       if @user.save
#         ThanksMailer.compelete_mail(@user).delivar_now
#         format.html { redirect_to @user, notice: 'User was successfully created' }
#         format.json { render :show, status: :created, location: @user }
#       else
#         format.html { render :new}
#         format.json { render json: @user.errors, status: :unprocessable_entity }
#       end
#     end
#   end
# end
