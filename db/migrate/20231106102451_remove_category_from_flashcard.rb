class RemoveCategoryFromFlashcard < ActiveRecord::Migration[7.0]
  def change
    remove_column :flashcards, :category, :string
  end
end
