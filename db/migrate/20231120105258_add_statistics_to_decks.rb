class AddStatisticsToDecks < ActiveRecord::Migration[7.0]
  def change
    add_column :decks, :total_correct_count, :integer, default: 0, null: false
    add_column :decks, :total_incorrect_count, :integer, default: 0, null: false
    add_column :decks, :total_attempts, :integer, default: 0, null: false
    add_column :decks, :average_accuracy, :float, default: 0.0, null: false
  end
end
