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
  belongs_to :deck 
  has_many :flashcard_statistics
  

  def self.search(params={})
    if params[:front]
      search_term = params[:front].downcase
      where("lower(front) LIKE ?", "%#{search_term}%")
    else
      all
    end
  end
  
  
end
