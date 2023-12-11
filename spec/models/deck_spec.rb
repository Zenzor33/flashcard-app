# == Schema Information
#
# Table name: decks
#
#  id                    :bigint           not null, primary key
#  average_accuracy      :float            default(0.0), not null
#  total_attempts        :integer          default(0), not null
#  total_correct_count   :integer          default(0), not null
#  total_incorrect_count :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint           not null
#
# Indexes
#
#  index_decks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Deck, type: :model do
  let(:deck) { FactoryBot.build(:deck) }

  describe 'validations' do 
    it "is valid with valid attributes" do 
      deck.valid?
      expect(deck).to be_valid 
    end 

    # context "user_id" do 
    #   it 'is invalid when user_id is not an integer' do 
    #     deck.user_id = "Not an integer"
    #     expect(deck).to_not be_valid 
    #   end
    # end

    describe 'associations' do 
      it {should belong_to(:user)}
    end 

    describe 'validations' do 
      it {should validate_presence_of(:total_incorrect_count)}
      it {should validate_numericality_of(:total_incorrect_count).only_integer.is_greater_than_or_equal_to(0)}

      it {should validate_presence_of(:total_correct_count)}
      it {should validate_numericality_of(:total_correct_count).only_integer.is_greater_than_or_equal_to(0)}

      it {should validate_presence_of(:total_attempts)}
      it {should validate_numericality_of(:total_correct_count).only_integer.is_greater_than_or_equal_to(0)}

      it {should validate_presence_of(:average_accuracy)}
      it do 
        should validate_numericality_of(:average_accuracy).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1)
      end
    end
    
  #   context "when validating total_correct_count" do 
  #     it 'is invalid when nil' do 
  #       deck.total_correct_count = nil
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:total_correct_count]).to include("can't be blank")
  #     end

  #     it 'is invalid when not an integer' do 
  #       deck.total_correct_count = 1.0
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:total_correct_count]).to include("must be an integer")
  #     end

  #     it 'is invalid when not greater than or equal to 0' do 
  #       deck.total_correct_count = -1
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:total_correct_count]).to include("must be greater than or equal to 0")
  #     end 
  #   end

  #   context "when validating average_accuracy" do 
  #     it 'is invalid when nil' do 
  #       deck.average_accuracy = nil
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:average_accuracy]).to include("can't be blank")
  #     end 

  #     it 'is invalid when not a float' do  
  #       deck.average_accuracy = 'not a number'
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:average_accuracy]).to include("is not a number")
  #     end 

  #     it 'is invalid when greater than 1.0' do 
  #       deck.average_accuracy = 1.1
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:average_accuracy]).to include("must be less than or equal to 1.0")
  #     end 

  #     it "is invalid when less than 0" do 
  #       deck.average_accuracy = -1
  #       expect(deck).to_not be_valid 
  #       expect(deck.errors[:average_accuracy]).to include("must be greater than or equal to 0")
  #     end 
  #   end 
  end
end
