# == Schema Information
#
# Table name: decks
#
#  id            :bigint           not null, primary key
#  flashcard_ids :integer          default([]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_decks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Deck < ApplicationRecord
  belongs_to :user
  has_many :deck_flashcards
  has_many :flashcards, through: :deck_flashcards

  def flashcard_statistics_for_user(user)
    FlashcardStatistic
      .joins(:flashcard)
      .where(flashcards: { id: flashcard_ids }, user: user)
  end

  def get_flashcards_by_category(user, category)
    if category == 'all'
      self.flashcards
    else 
      self.flashcard_statistics_for_user(user).where(category: category)
    end
  end 

  def correct_count_sum(user, category)
    category == 'all' ? flashcard_statistics_for_user(user).sum(:correct_count) : flashcard_statistics_for_user(user).where(category: category).sum(:correct_count) 
  end 

  def incorrect_count_sum(user, category)
    category == 'all' ? flashcard_statistics_for_user(user).sum(:correct_count) : flashcard_statistics_for_user(user).where(category: category).sum(:incorrect_count)
  end 

  def accuracy(correct_count, incorrect_count)
    ((correct_count.to_f / (correct_count + incorrect_count)) * 100).round(0)
  end 



  def add_flashcard_to_deck(flashcard)
    self.flashcards.push(flashcard)
    save
  end 

  def remove_flashcard_from_deck(flashcard)
    self.flashcards.delete(flashcard)
    save
  end 
end
