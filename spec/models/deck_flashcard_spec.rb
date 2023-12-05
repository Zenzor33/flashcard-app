require 'rails_helper'

RSpec.describe DeckFlashcard, type: :model do
  context "by_category" do 
    it "returns all deck flashcards when category is 'all'" do 
      # Persist user
      user = User.create!(email: "test@example.com", password: "secret")
      # Persist 3 flashcards
      flashcard1 = Flashcard.create!(front: "Hello", back: "Oi")
      flashcard2 = Flashcard.create!(front: "Goodbye", back: "Tchau")
      flashcard3 = Flashcard.create!(front: "Good Morning", back: "Bom Dia")
      # Persist 3 deck flashcards
      deckflashcard1 = user.deck.deck_flashcards.create!(flashcard_id: flashcard1.id)
      deckflashcard2 = user.deck.deck_flashcards.create!(flashcard_id: flashcard2.id)
      deckflashcard3 = user.deck.deck_flashcards.create!(flashcard_id: flashcard3.id)
      #Execute the query
      result = DeckFlashcard.by_category('all')
    
      expect(result).to match_array(DeckFlashcard.all)
    end

    it "returns only deck flashcards that belong to the specified category" do 
      # Persist user
      user = User.create!(email: "test@example.com", password: "secret")
      # Persist 3 flashcards
      flashcard1 = Flashcard.create!(front: "Hello", back: "Oi")
      flashcard2 = Flashcard.create!(front: "Goodbye", back: "Tchau")
      flashcard3 = Flashcard.create!(front: "Good Morning", back: "Bom Dia")
      # Persist 3 deck flashcards
      deckflashcard1 = user.deck.deck_flashcards.create!(flashcard_id: flashcard1.id)
      deckflashcard2 = user.deck.deck_flashcards.create!(flashcard_id: flashcard2.id)
      deckflashcard3 = user.deck.deck_flashcards.create!(flashcard_id: flashcard3.id, category: "mastered") 
      #Execute the query
      result = DeckFlashcard.by_category('new')
    
      expect(result).to include(deckflashcard1, deckflashcard2)
      expect(result).to_not include(deckflashcard3)
    end 
  end 
end
