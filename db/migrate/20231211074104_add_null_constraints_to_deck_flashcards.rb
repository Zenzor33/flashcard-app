class AddNullConstraintsToDeckFlashcards < ActiveRecord::Migration[7.0]
  def change
    change_column_null :deck_flashcards, :accuracy, false
    change_column_null :deck_flashcards, :category, false
    change_column_null :deck_flashcards, :correct_count, false
    change_column_null :deck_flashcards, :incorrect_count, false
  end
end
