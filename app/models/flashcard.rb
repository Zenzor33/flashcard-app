# == Schema Information
#
# Table name: flashcards
#
#  id         :bigint           not null, primary key
#  back       :string
#  front      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Flashcard < ApplicationRecord
  has_many :flashcard_statistics
  has_many :users, through: :flashcard_statistics

end
