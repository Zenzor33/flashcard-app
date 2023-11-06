class AddCategoryToFlashcardStatistics < ActiveRecord::Migration[7.0]
  def change
    add_column :flashcard_statistics, :category, :string, default: 'new'
  end
end
