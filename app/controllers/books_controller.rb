class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only: [:edit, :update]
  before_action :ranking_books

  def index
    if params[:submit_select]
      sort_books
    elsif params[:sort]
      @books = Book.order(sort_column + ' ' + sort_direction).page(params[:page])
    elsif params[:tag]
      @books = Book.tagged_with(params[:tag]).page(params[:page])
    else
      @books = Book.page(params[:page])
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
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to @book
    else
      @user = current_user
      @books = Book.all.page(params[:page])
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

    def sort_books
      case params[:submit_select]
      when "0"
        @books = Book.page(params[:page])
      when "1"
        @books = Book.order(created_at: :desc).page(params[:page])
      when "2"
        @books = Kaminari.paginate_array(Book.all_rank).page(params[:page])
      when "3"
        @books = Kaminari.paginate_array(Book.order_comment).page(params[:page])
      end
    end
end
