class Flashcard < ApplicationRecord
  has_many :flashcardstatistics
  has_many :users, through: :flashcardstatistics

end
