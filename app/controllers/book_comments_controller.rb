class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @new_book = Book.new
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      flash[:notice] = "You have commented successfully"
    else
      @book_comments = BookComment.where(id: @book)
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:book_id])
    @book = @book_comment.book
    if @book_comment.user != current_user
      redirect_to @book
    end
    @book_comment.destroy

  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
