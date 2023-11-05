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

  def get_flashcards_by_category(category)
    Flashcard.where(category: category)
  end 

  def add_flashcard_to_deck(flashcard_id)
    self.flashcard_ids << flashcard_id
    save
  end 

  def remove_flashcard_from_deck(flashcard_id)
    self.flashcard_ids.delete(flashcard_id)
    save
  end 
end
