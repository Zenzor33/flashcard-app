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
