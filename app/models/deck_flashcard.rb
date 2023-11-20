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

  private

  def update_accuracy
    total = correct_count + incorrect_count
    self.accuracy = total.zero? ? 0.0 : (correct_count.to_f / total * 100)
  end

  def update_total_count
    self.total_count = correct_count.to_i + incorrect_count.to_i
  end 
end
