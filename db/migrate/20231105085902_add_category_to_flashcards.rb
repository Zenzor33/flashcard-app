class AddCategoryToFlashcards < ActiveRecord::Migration[7.0]
  def change
    add_column :flashcards, :category, :string, default: 'new', null: false
  end
end
