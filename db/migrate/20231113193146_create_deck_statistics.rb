class CreateDeckStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :deck_statistics do |t|
      t.references :deck, null: false, foreign_key: true

      t.integer :correct_count, default: 0, null: false
      t.integer :incorrect_count, default: 0, null: false
      t.integer :total_count, default: 0, null: false
      t.float :accuracy, default: 0.0, null: false

      t.timestamps
    end
  end
end
