# == Schema Information
#
# Table name: flashcards
#
#  id         :bigint           not null, primary key
#  back       :string
#  category   :string           default("new"), not null
#  front      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Flashcard < ApplicationRecord
  has_many :flashcard_statistics
  has_many :users, through: :flashcard_statistics
  has_many :deck_flashcards

  def self.search(params={})
    if params[:front]
      search_term = params[:front].downcase
      where("lower(front) LIKE ?", "%#{search_term}%")
    else
      all
    end
  end
  
  
end
