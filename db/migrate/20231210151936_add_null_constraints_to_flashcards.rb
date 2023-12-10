class AddNullConstraintsToFlashcards < ActiveRecord::Migration[7.0]
  def change
    change_column_null :flashcards, :front, false
    change_column_null :flashcards, :back, false
  end
end
