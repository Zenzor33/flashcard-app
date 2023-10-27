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

  def self.search(params)
    if params && params[:search][:front].present?
      search_term = params[:search][:front]
      where("lower(front) LIKE ?", "%#{search_term.downcase}%")
    else
      all
    end
  end  
end
