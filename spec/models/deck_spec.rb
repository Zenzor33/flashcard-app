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

  # associations

  # it "is valid when associated with a user" do 
  #   user = User.create!(email: "deck_test@example.com", password: "secret")
  #   deck = user.deck
  #   deck.valid?
  #   expect(deck).to be_valid 
  # end 

  it "is valid when associated with a user" do 
    deck = FactoryBot.create(:deck)
    deck.valid?
    expect(deck).to be_valid 
  end 

  # validations

  context "user_id" do 
    # it 'is invalid when user_id is not an integer' do 
    #   deck = Deck.new(user_id: 1.0)
    #   expect(deck).to_not be_valid 
    # end
    
    it 'is invalid when user_id is not an integer' do 
      deck = FactoryBot.build(:deck, user_id: "Not an integer")
      expect(deck).to_not be_valid 
    end
  
  end
  
  # validates :total_correct_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  context "total_correct_count" do 

    it 'is invalid when nil' do 
      # deck = Deck.new(total_correct_count: nil)
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:total_correct_count]).to include("can't be blank")

      deck = FactoryBot.build(:deck, total_correct_count: nil)
      expect(deck).to_not be_valid 
      expect(deck.errors[:total_correct_count]).to include("can't be blank")

    end

    it 'is invalid when not an integer' do 
      # deck = Deck.new(total_correct_count: 1.0)
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:total_correct_count]).to include("must be an integer")

      deck = FactoryBot.build(:deck, total_correct_count: 1.0)
      expect(deck).to_not be_valid 
      expect(deck.errors[:total_correct_count]).to include("must be an integer")
    end

    it 'is invalid when not greater than or equal to 0' do 
      # deck = Deck.new(total_correct_count: -1)
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:total_correct_count]).to include("must be greater than or equal to 0")

      deck = FactoryBot.build(:deck, total_correct_count: -1)
      expect(deck).to_not be_valid 
      expect(deck.errors[:total_correct_count]).to include("must be greater than or equal to 0")
    end 

  end

  # validates :average_accuracy, presence: true, numericality: { only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1.0}
  context "average_accuracy" do 

    it 'is invalid when nil' do 
      # deck = Deck.new(average_accuracy: nil)
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:average_accuracy]).to include("can't be blank")

      deck = FactoryBot.build(:deck, average_accuracy: nil)
      expect(deck).to_not be_valid 
      expect(deck.errors[:average_accuracy]).to include("can't be blank")
    end 

    it 'is invalid when not a float' do  
      # deck = Deck.new(average_accuracy: 'not a number')
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:average_accuracy]).to include("is not a number")

      deck = FactoryBot.build(:deck, average_accuracy: 'not a number')
      expect(deck).to_not be_valid 
      expect(deck.errors[:average_accuracy]).to include("is not a number")
    end 

    it 'is invalid when greater than 1.0' do 
      # deck = Deck.new(average_accuracy: 1.1)
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:average_accuracy]).to include("must be less than or equal to 1.0")

      deck = FactoryBot.build(:deck, average_accuracy: 1.1)
      expect(deck).to_not be_valid 
      expect(deck.errors[:average_accuracy]).to include("must be less than or equal to 1.0")
    end 

    it "is invalid when less than 0" do 
      # deck = Deck.new(average_accuracy: -1)
      # expect(deck).to_not be_valid 
      # expect(deck.errors[:average_accuracy]).to include("must be greater than or equal to 0")

      deck = FactoryBot.build(:deck, average_accuracy: -1)
      expect(deck).to_not be_valid 
      expect(deck.errors[:average_accuracy]).to include("must be greater than or equal to 0")
    end 

  end 
end
