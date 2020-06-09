class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only: [:edit, :update]
  before_action :ranking_books

  helper_method :sort_column, :sort_direction

  def index
    if params[:submit_select]
      sort_books
    elsif params[:sort]
      @books = Book.order(sort_column + ' ' + sort_direction)
    elsif params[:tag]
      @books = Book.tagged_with(params[:tag])
    else
      @books = Book.all
    end
    @book = Book.new
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_commets = @book.book_comments
    @user = User.find(@book.user_id)
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    byebug
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :tag_list)
    end

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def correct_book
      @book = Book.find(params[:id])
      unless @book.user == current_user
        redirect_to books_path
      end
    end

    def sort_column
      Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_books
      case params[:submit_select]
      when "0"
        @books = Book.all
      when "1"
        @books = Book.all.order(created_at: :desc)
      when "2"
        @books = Book.all_rank
      when "3"
        @books = Book.order_comment
      end
    end
end
