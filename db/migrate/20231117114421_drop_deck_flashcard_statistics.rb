class DropDeckFlashcardStatistics < ActiveRecord::Migration[7.0]
  def up
    drop_table :deck_flashcard_statistics
  end

  def down
    create_table :deck_flashcard_statistics do |t|
      t.bigint "deck_flashcard_id", null: false
      t.integer "correct_count", default: 0, null: false
      t.integer "incorrect_count", default: 0, null: false
      t.float "accuracy", default: 0.0, null: false
      t.integer "total_count", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["deck_flashcard_id"], name: "index_deck_flashcard_statistics_on_deck_flashcard_id"
    end
    add_foreign_key :deck_flashcard_statistics, :deck_flashcards
  end
end
