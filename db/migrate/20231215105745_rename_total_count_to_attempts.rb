class RenameTotalCountToAttempts < ActiveRecord::Migration[7.0]
  def change
    rename_column :deck_flashcards, :total_count, :attempts
  end
end
