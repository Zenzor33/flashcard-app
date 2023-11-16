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
require "test_helper"

class DeckFlashcardStatisticTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
