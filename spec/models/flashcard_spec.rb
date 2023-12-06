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
require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  before do 
    @flashcard1 = Flashcard.create!(front: "Hello", back: "Oi")
    @flashcard2 = Flashcard.create!(front: "Goodbye", back: "Tchau")
  end 

  context "search" do 
    it "returns matching flashcard if search term exists" do 
      params = { :front => "Go" }
      flashcards = Flashcard.search(params)
      expect(flashcards).to include(@flashcard2)
    end

    it "returns all flashcards if params[:front] does not exist" do 
      params = { }
      result = Flashcard.search(params)
      expect(result).to match_array(Flashcard.all)
    end 
  end 
end
