# == Schema Information
#
# Table name: flashcard_statistics
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0)
#  category        :string           default("new")
#  correct_count   :integer          default(0)
#  incorrect_count :integer          default(0)
#  total_count     :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flashcard_id    :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_flashcard_statistics_on_flashcard_id  (flashcard_id)
#  index_flashcard_statistics_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (flashcard_id => flashcards.id)
#  fk_rails_...  (user_id => users.id)
#
# class FlashcardStatistic < ApplicationRecord
#   belongs_to :user 
#   belongs_to :flashcard  

#   before_save :update_total_count, :update_accuracy

#   def accuracy 
#     total = correct_count + incorrect_count
#     (correct_count.to_f / total)
#   end 

#   private

#   def update_accuracy
#     total = correct_count + incorrect_count
#     self.accuracy = total.zero? ? 0.0 : (correct_count.to_f / total * 100)
#   end

#   def update_total_count
#     self.total_count = correct_count.to_i + incorrect_count.to_i
#   end 

#   def update_category 
    
#   end 


# end
