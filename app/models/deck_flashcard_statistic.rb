# == Schema Information
#
# Table name: deck_flashcard_statistics
#
#  id                :bigint           not null, primary key
#  accuracy          :float            default(0.0), not null
#  correct_count     :integer          default(0), not null
#  incorrect_count   :integer          default(0), not null
#  total_count       :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  deck_flashcard_id :bigint           not null
#
# Indexes
#
#  index_deck_flashcard_statistics_on_deck_flashcard_id  (deck_flashcard_id)
#
# Foreign Keys
#
#  fk_rails_...  (deck_flashcard_id => deck_flashcards.id)
#
class DeckFlashcardStatistic < ApplicationRecord
  belongs_to :deck_flashcard, dependent: :destroy

  before_save :update_total_count, :update_accuracy

  def accuracy 
    total = correct_count + incorrect_count
    (correct_count.to_f / total)
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
