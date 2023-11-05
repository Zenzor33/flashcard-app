# == Schema Information
#
# Table name: decks
#
#  id            :bigint           not null, primary key
#  flashcard_ids :integer          default([]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_decks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Deck < ApplicationRecord
  belongs_to :user
  has_many :deck_flashcards
  has_many :flashcards, through: :deck_flashcards

  def get_flashcards_by_category(category)
    if category == 'all'
      self.flashcards
    else 
      self.flashcards.where(category: category)
    end
  end 

  def add_flashcard_to_deck(flashcard)
    self.flashcards.push(flashcard)
    save
  end 

  def remove_flashcard_from_deck(flashcard)
    self.flashcards.delete(flashcard)
    save
  end 
end
