class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @new_book = Book.new
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash[:notice] = "You have commented successfully"
      redirect_back(fallback_location: root_path)
    else
      @book_comments = BookComment.where(book_id: @book.id)
      @user = User.find(@book.user_id)
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.find_by(book_id: @book.id)
    @book_comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
