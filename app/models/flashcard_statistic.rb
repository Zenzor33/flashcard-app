# == Schema Information
#
# Table name: flashcard_statistics
#
#  id              :integer          not null, primary key
#  correct_count   :integer          default(0)
#  incorrect_count :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flashcard_id    :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_flashcard_statistics_on_flashcard_id  (flashcard_id)
#  index_flashcard_statistics_on_user_id       (user_id)
#
# Foreign Keys
#
#  flashcard_id  (flashcard_id => flashcards.id)
#  user_id       (user_id => users.id)
#
class FlashcardStatistic < ApplicationRecord
  belongs_to :user 
  belongs_to :flashcard  

end
