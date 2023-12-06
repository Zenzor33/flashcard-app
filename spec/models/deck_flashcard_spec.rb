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

    before(:each) do 
      
      @user = User.create!(email: "test@example.com", password: "secret")
      
      @flashcard1 = Flashcard.create!(front: "Hello", back: "Oi")
      @flashcard2 = Flashcard.create!(front: "Goodbye", back: "Tchau")
      @flashcard3 = Flashcard.create!(front: "Good Morning", back: "Bom Dia")
    end 

    context "when category is all" do 
      it "returns all deck flashcards" do 
        deckflashcard1 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard1.id)
        deckflashcard2 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard2.id)
        deckflashcard3 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard3.id)

        result = DeckFlashcard.by_category('all')
      
        expect(result).to match_array(DeckFlashcard.all)
      end
    end

    context "when category is specified" do 
      it "returns only deck flashcards that belong to the specified category" do 
        deckflashcard1 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard1.id)
        deckflashcard2 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard2.id)
        deckflashcard3 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard3.id, category: "mastered") 
        
        result = DeckFlashcard.by_category('new')
      
        expect(result).to include(deckflashcard1, deckflashcard2)
        expect(result).to_not include(deckflashcard3)
      end 
    end

    context "when category is empty" do 
      it "returns an empty collection" do 
        deckflashcard1 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard1.id)
        deckflashcard2 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard2.id)
        deckflashcard3 = @user.deck.deck_flashcards.create!(flashcard_id: @flashcard3.id, category: "mastered") 
        
        result = DeckFlashcard.by_category('learning')
      
        expect(result).to be_empty
      end 
    end 
  end
end
