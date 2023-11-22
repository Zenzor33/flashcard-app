# == Schema Information
#
# Table name: deck_flashcards
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0)
#  category        :string           default("new")
#  correct_count   :integer          default(0)
#  incorrect_count :integer          default(0)
#  total_count     :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deck_id         :bigint           not null
#  flashcard_id    :bigint           not null
#
# Indexes
#
#  index_deck_flashcards_on_deck_id                   (deck_id)
#  index_deck_flashcards_on_deck_id_and_flashcard_id  (deck_id,flashcard_id) UNIQUE
#  index_deck_flashcards_on_flashcard_id              (flashcard_id)
#
# Foreign Keys
#
#  fk_rails_...  (deck_id => decks.id)
#  fk_rails_...  (flashcard_id => flashcards.id)
#
class DeckFlashcard < ApplicationRecord
  belongs_to :deck
  belongs_to :flashcard

  before_save :update_total_count, :update_accuracy

  def self.flashcard 
    Flashcard.find_by(self.flashcard_id)
  end 

  def self.average_accuracy
    total_attempts = self.total_correct_count + self.total_incorrect_count
    return 0.0 if total_attempts.zero? 
    
    accuracy = self.total_correct_count.to_f / total_attempts
    accuracy.nan? ? 0.0 : accuracy
  end 

  def self.total_correct_count
    self.sum(:correct_count)
  end

  def self.total_incorrect_count
    self.sum(:incorrect_count)
  end

  private

  def update_accuracy
    total = correct_count + incorrect_count
    self.accuracy = total.zero? ? 0.0 : (correct_count.to_f / total * 100)
  end

  def update_total_count
    self.total_count = correct_count.to_i + incorrect_count.to_i
  end 
end
