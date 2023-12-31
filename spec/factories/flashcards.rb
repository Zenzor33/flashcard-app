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
FactoryBot.define do
  factory :flashcard do
    sequence(:front) { |n| "Front+#{n}"}
    sequence(:back) { |n| "Back+#{n}" }
  end
end
