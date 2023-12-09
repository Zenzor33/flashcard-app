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
require 'rails_helper'

RSpec.describe DeckFlashcard, type: :model do
  describe ".by_category" do 

    let(:user) { FactoryBot.create(:user) }
    let!(:flashcards) { FactoryBot.create_list(:flashcard, 3) }
    let!(:deck_flashcards) {
      flashcards.each do |flashcard|
        user.deck.deck_flashcards.create!(flashcard_id: flashcard.id)
      end 
    }

    before(:each) do 
      @deckflashcard1 = DeckFlashcard.first
      @deckflashcard2 = DeckFlashcard.second
      @deckflashcard3 = DeckFlashcard.third
    end 

    context "all" do 
      it "returns all deck flashcards" do 
        result = DeckFlashcard.by_category('all')
        expect(result).to match_array(DeckFlashcard.all)
      end
    end

    context "is specified" do 
      it "returns only deck_flashcards that belong to the specified category" do 
        @deckflashcard3.update(category: "mastered") #Note that before(:each) ensures that a database rollback prevents this transaction from effecting subsequent tests. 
        result = DeckFlashcard.by_category('new')
      
        expect(result).to include(@deckflashcard1, @deckflashcard2)
        expect(result).to_not include(@deckflashcard3)
      end 
    end

    context "is empty" do 
      it "returns an empty collection" do 
        result = DeckFlashcard.by_category('mastered')
        expect(result).to be_empty
      end 
    end 
  end
end
