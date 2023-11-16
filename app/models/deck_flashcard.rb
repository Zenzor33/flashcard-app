# == Schema Information
#
# Table name: deck_flashcards
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0)
#  category        :string           default("new")
#  correct_count   :integer          default(0)
#  incorrect_count :integer          default(0)
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
  has_one :deck_flashcard_statistic, dependent: :destroy

  after_create :create_deck_flashcard_statistic

  private

  def create_deck_flashcard_statistic
    DeckFlashcardStatistic.create(deck_flashcard: self)
  end
end
