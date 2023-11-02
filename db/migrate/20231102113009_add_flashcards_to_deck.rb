class AddFlashcardsToDeck < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :flashcard_ids, :integer, array: true, default: []
  end
end
