class AddTotalCountToDeckFlashcard < ActiveRecord::Migration[7.0]
  def change
    add_column :deck_flashcards, :total_count, :integer, default: 0, null: false
  end
end
