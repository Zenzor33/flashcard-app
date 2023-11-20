class DropDeckStatisticsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :deck_statistics
  end

  def down
    create_table :deck_statistics do |t|
      t.bigint :deck_id, null: false
      t.integer :correct_count, default: 0, null: false
      t.integer :incorrect_count, default: 0, null: false
      t.integer :total_count, default: 0, null: false
      t.float :accuracy, default: 0.0, null: false
      t.timestamps
    end
    add_index :deck_statistics, :deck_id
    add_foreign_key :deck_statistics, :decks
  end
end

