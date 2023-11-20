# == Schema Information
#
# Table name: decks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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
  has_one :deck_statistic

  after_create :assign_default_deck_statistic 

  def get_deck_flashcards_by_category(user, category)
    category == 'all' ? self.deck_flashcards : self.deck_flashcards.where(category: category)
  end 

  # Requires update. 
  # This method sums the correct_count of the decks deck_flashcards. 
  # Should be a hook / callback
  def correct_count_sum(user, category)
    category == 'all' ? self.deck_statistic.correct_count : self.deck_statistic.correct_count
  end 

  def incorrect_count_sum(user, category)
    category == 'all' ? self.deck_statistic.incorrect_count : self.deck_statistic.incorrect_count
  end 

  def accuracy(correct_count, incorrect_count)
    total = correct_count + incorrect_count
    return 0 if total.zero?
    ((correct_count.to_f / total) * 100).round(0)
  end



  def add_flashcard_to_deck(flashcard)
    self.deck_flashcards.create(flashcard_id: flashcard.id)
    save
  end 

  def remove_flashcard_from_deck(flashcard)
    deck_flashcard = self.deck_flashcards.find_by(flashcard: flashcard)
    deck_flashcard.destroy
  end 

  private 

  def assign_default_deck_statistic 
   build_deck_statistic.save 
  end
end
