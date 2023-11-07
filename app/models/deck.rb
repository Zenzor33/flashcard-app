# == Schema Information
#
# Table name: decks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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

  def get_flashcard_statistics_by_category(user, category)
    if category == 'all'
      self.flashcard_statistics_for_user(user)
    else 
      self.flashcard_statistics_for_user(user).where(category: category)
    end
  end 

  def get_flashcards_by_category(user, category)
    if category == 'all'
      self.flashcards 
    else  
      statistics = self.get_flashcard_statistics_by_category(user, category)
      flashcard_ids = statistics.map(&:flashcard_id)
      Flashcard.where(id: flashcard_ids)
    end 
  end 

  # def get_flashcard_accuracy(user, flashcard)
  #   flashcard_statistics = self.flashcard_statistics_for_user(user).find_by(flashcard_id: flashcard)
  #   correct_count = flashcard_statistics.correct_count
  #   incorrect_count = flashcard_statistics.incorrect_count
  #   total_count = correct_count + incorrect_count
  #   return 0 if total.zero?
  #   ((correct_count.to_f / total) * 100).round(0)
  # end 

  def correct_count_sum(user, category)
    category == 'all' ? flashcard_statistics_for_user(user).sum(:correct_count) : flashcard_statistics_for_user(user).where(category: category).sum(:correct_count) 
  end 

  def incorrect_count_sum(user, category)
    category == 'all' ? flashcard_statistics_for_user(user).sum(:incorrect_count) : flashcard_statistics_for_user(user).where(category: category).sum(:incorrect_count)
  end 

  def accuracy(correct_count, incorrect_count)
    total = correct_count + incorrect_count
    return 0 if total.zero?
    ((correct_count.to_f / total) * 100).round(0)
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
