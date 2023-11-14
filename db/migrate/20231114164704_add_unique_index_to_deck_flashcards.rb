class AddUniqueIndexToDeckFlashcards < ActiveRecord::Migration[7.0]
  def change
    add_index :deck_flashcards, [:deck_id, :flashcard_id], unique: true
  end
end
