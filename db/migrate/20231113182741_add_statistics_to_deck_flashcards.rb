class AddStatisticsToDeckFlashcards < ActiveRecord::Migration[7.0]
  def change
    add_column :deck_flashcards, :correct_count, :integer, default: 0
    add_column :deck_flashcards, :incorrect_count, :integer, default: 0
    add_column :deck_flashcards, :accuracy, :float, default: 0.0
    add_column :deck_flashcards, :category, :string, default: 'new'
  end
end
