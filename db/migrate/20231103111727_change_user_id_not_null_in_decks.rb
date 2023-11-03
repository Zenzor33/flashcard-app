class ChangeUserIdNotNullInDecks < ActiveRecord::Migration[7.0]
  def change
    change_column :decks, :user_id, :bigint, null: false
  end
end

