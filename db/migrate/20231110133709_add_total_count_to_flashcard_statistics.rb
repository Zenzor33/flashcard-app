class AddTotalCountToFlashcardStatistics < ActiveRecord::Migration[7.0]
  def change
    add_column :flashcard_statistics, :total_count, :integer, default: 0, null: false
  end
end
