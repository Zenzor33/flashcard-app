require 'rails_helper'

RSpec.describe Deck, type: :model do
  # validations

  # validates :user_id, presence: true, numericality: { only_integer: true }
  it 'is invalid when user_id is nil'
  it 'is invalid when user_id is not an integer'
  
  # validates :total_correct_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  it 'is invalid when total_correct_count is nil'
  it 'is invalid when total_correct_count is not an integer'
  it 'is invalid when total_correct_count is not greater than or equal to 0'

  # validates :average_accuracy, presence: true, numericality: { only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1.0}
  it 'is invalid when average_accuracy is nil'
  it 'is invalid when average_accuracy is not a float'
  it 'is invalid when average_accuracy is not greater than or equal to 0.0 and not less than or equal to 1.0'

end
