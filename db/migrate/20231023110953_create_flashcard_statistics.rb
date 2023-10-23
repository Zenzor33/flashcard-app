class CreateFlashcardStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :flashcard_statistics do |t|
      t.integer :correct_count, default: 0
      t.integer :incorrect_count, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
