class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :rank, -> { order('count(book_id) desc') }
end
