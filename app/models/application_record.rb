class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :my_book, -> (current_user) { joins(:book).where(books: { user_id: current_user.id }) }
  scope :rank, -> { order('count(book_id) desc') }
end
