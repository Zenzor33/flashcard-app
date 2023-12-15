# == Schema Information
#
# Table name: deck_flashcards
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0), not null
#  attempts        :integer          default(0), not null
#  category        :string           default("new"), not null
#  correct_count   :integer          default(0), not null
#  incorrect_count :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deck_id         :bigint           not null
#  flashcard_id    :bigint           not null
#
# Indexes
#
#  index_deck_flashcards_on_deck_id                   (deck_id)
#  index_deck_flashcards_on_deck_id_and_flashcard_id  (deck_id,flashcard_id) UNIQUE
#  index_deck_flashcards_on_flashcard_id              (flashcard_id)
#
# Foreign Keys
#
#  fk_rails_...  (deck_id => decks.id)
#  fk_rails_...  (flashcard_id => flashcards.id)
#
FactoryBot.define do
  factory :deck_flashcard do
    association :deck 
    association :flashcard 
    incorrect_count { 0 }
    correct_count { 0 }
    attempts { 0 }
    accuracy { 0.0 }
    category { "new" }

    trait :learning do 
      incorrect_count { 0 }
      correct_count { 1 }
      # category { "learning "}
    end 

    trait :progressing do 
      incorrect_count { 3 }
      correct_count { 8 }
      # category { "progressing" }
    end 

    trait :mastered do
      incorrect_count { 1 }
      correct_count { 9 }
      # category { "mastered" }
    end
  end
end
