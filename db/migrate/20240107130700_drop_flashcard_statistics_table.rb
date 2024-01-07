class DropFlashcardStatisticsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :flashcard_statistics
  end
end
