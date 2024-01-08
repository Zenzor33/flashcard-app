# == Schema Information
#
# Table name: flashcards
#
#  id         :bigint           not null, primary key
#  back       :string           not null
#  front      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Flashcard < ApplicationRecord
  has_many :deck_flashcards, dependent: :destroy

  validates :front, presence: true 
  validates :back, presence: true

  scope :search, -> (params = {}) {
    if params[:front]
      search_term = params[:front].downcase
      where("lower(front) LIKE ?", "%#{search_term}%")
    else
      all
    end
  }

  scope :sorted_by, -> (sort_order) {
    case sort_order 
    when "front_asc"
      order(front: :asc)
    when "front_desc"
      order(front: :desc)
    when "back_asc"
      order(back: :asc)
    when "back_desc"
      order(back: :desc)
    end
  }
end
