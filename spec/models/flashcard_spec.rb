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
require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  
  let!(:flashcard1) {Flashcard.create!(front: "Hello", back: "Oi")}
  let!(:flashcard2) {Flashcard.create!(front: "Goodbye", back: "Tchau")}

  it { should validate_presence_of(:front) }
  it { should validate_presence_of(:back) }

  context "search" do 
    it "returns matching flashcard if search term exists" do 
      params = { :front => "He" }
      flashcards = Flashcard.search(params)
      expect(flashcards).to include(flashcard1)
      expect(flashcards).to_not include(flashcard2)
    end

    it "returns all flashcards if params[:front] does not exist" do 
      params = { }
      result = Flashcard.search(params)
      expect(result).to match_array(Flashcard.all)
    end 
  end 
end
