# == Schema Information
#
# Table name: deck_flashcards
#
#  id              :bigint           not null, primary key
#  accuracy        :float            default(0.0), not null
#  category        :string           default("new"), not null
#  correct_count   :integer          default(0), not null
#  incorrect_count :integer          default(0), not null
#  total_count     :integer          default(0), not null
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
require 'rails_helper'

RSpec.describe DeckFlashcard, type: :model do

  describe 'associations' do 
    it { should belong_to(:deck) }
    it { should belong_to(:flashcard) }
  end 

  describe 'validations' do 
    [:accuracy, :category, :correct_count, :incorrect_count, :total_count].each {
      |attribute| it {should validate_presence_of(attribute)}
    }
    [:correct_count, :incorrect_count, :total_count].each {
      |attribute| it {should validate_numericality_of(attribute).only_integer.is_greater_than_or_equal_to(0)}
    }
    it do 
      should validate_numericality_of(:accuracy).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100)
    end
  end

  describe ".by_category" do 
    let!(:new_flashcards) { FactoryBot.create_list(:deck_flashcard, 2)}
    let!(:mastered_flashcards) { FactoryBot.create_list(:deck_flashcard, 1, :mastered) }

    context "nil" do 
      it "returns all deck flashcards" do 
        result = DeckFlashcard.by_category(nil)
        expect(result).to match_array(DeckFlashcard.all)
      end
    end

    context "is specified" do 
      it "returns only deck_flashcards that belong to the specified category" do 
        # binding.pry
        expect(DeckFlashcard.by_category("new")).to match_array(new_flashcards)
        expect(DeckFlashcard.by_category("mastered")).to match_array(mastered_flashcards)
      end 
    end

    context "is empty" do 
      it "returns an empty collection" do 
        result = DeckFlashcard.by_category('learning')
        expect(result).to be_empty
      end 
    end 
  end
end
