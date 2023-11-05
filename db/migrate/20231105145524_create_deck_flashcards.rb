class CreateDeckFlashcards < ActiveRecord::Migration[7.0]
  def change
    create_table :deck_flashcards do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end

  # Assuming the old decks have a 'flashcard_ids' column that contains an array of flashcard IDs
  # Deck.find_each do |deck|
  #   deck.flashcard_ids.each do |flashcard_id|
  #     DeckFlashcard.create!(deck: deck, flashcard_id: flashcard_id)
  #   end
  # end
end
