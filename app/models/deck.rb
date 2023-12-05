# == Schema Information
#
# Table name: decks
#
#  id                    :bigint           not null, primary key
#  average_accuracy      :float            default(0.0), not null
#  total_attempts        :integer          default(0), not null
#  total_correct_count   :integer          default(0), not null
#  total_incorrect_count :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint           not null
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

  # NOTE: You don't need this. ActiveRecord enforces relationships for you automatically.
  # validates :user_id, presence: true, numericality: { only_integer: true }
  validates :total_correct_count,
            :total_incorrect_count, 
            :total_attempts,
            presence: true, 
            numericality: { 
              only_integer: true, 
              greater_than_or_equal_to: 0 
            }
  validates :average_accuracy, 
            presence: true, 
            numericality: { 
              only_float: true, 
              greater_than_or_equal_to: 0, 
              less_than_or_equal_to: 1.0
            }


  def add_flashcard(flashcard)
    self.deck_flashcards.create(flashcard_id: flashcard.id)
  end 

  def remove_flashcard(flashcard)
    deck_flashcard = self.deck_flashcards.find_by(flashcard: flashcard)
    deck_flashcard.destroy
  end 
  
  def update_statistics
    if self.deck_flashcards.exists?
      update_counts
      update_average_accuracy
    else  
      reset_statistics
    end 
  end

  private 

  def update_counts 
    self.total_correct_count = self.deck_flashcards.total_correct_count
    self.total_incorrect_count = self.deck_flashcards.total_incorrect_count
    save
  end 

  def update_average_accuracy
    average_accuracy = self.total_correct_count / (self.total_correct_count.to_f + self.total_incorrect_count )
    self.average_accuracy = average_accuracy.nan? ? 0 : average_accuracy
    save
  end  

  #Improvement - analyze later
  # def update_average_accuracy
  #   denominator = (total_correct_count + total_incorrect_count ).to_f

  #   if denominator.zero?
  #     update(average_accuracy: 0)
  #   else
  #     update(average_accuracy: total_correct_count / denominator)
  #   end
  # end  

  def reset_statistics
    self.total_correct_count = 0
    self.total_incorrect_count = 0
    self.average_accuracy = 0.0
    save
  end 
end
