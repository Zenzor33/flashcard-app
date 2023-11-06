class RemoveFlashcardIdsFromDecks < ActiveRecord::Migration[7.0]
  def change
    remove_column :decks, :flashcard_ids, :integer, array: true, default: []
  end
end
