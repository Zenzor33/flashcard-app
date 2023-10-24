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
require "test_helper"

class FlashcardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
