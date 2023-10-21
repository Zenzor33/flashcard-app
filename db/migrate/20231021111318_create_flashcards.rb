class CreateFlashcards < ActiveRecord::Migration[7.0]
  def change
    create_table :flashcards do |t|
      t.string :front
      t.string :back

      t.timestamps
    end
  end
end
