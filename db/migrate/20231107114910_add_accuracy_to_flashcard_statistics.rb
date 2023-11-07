class AddAccuracyToFlashcardStatistics < ActiveRecord::Migration[7.0]
  def change
    add_column :flashcard_statistics, :accuracy, :float, default: 0.0
  end
end
