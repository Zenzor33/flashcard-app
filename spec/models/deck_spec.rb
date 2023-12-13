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

    # describe 'validations' do 
    #   it "is valid with valid attributes" do 
    #     deck.valid?
    #     expect(deck).to be_valid 
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
end
