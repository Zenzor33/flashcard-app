require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  context "search" do 
    it "returns matching flashcard if search term exists" do 
      # Persist flashcard1
      flashcard1 = Flashcard.create!(front: "Hello", back: "Oi")
      # Persist flashcard2
      flashcard2 = Flashcard.create!(front: "Goodbye", back: "Tchau")
      # Run query that matches flashcard2 and assign result to variable
      params = { :front => "Go" }
      result = Flashcard.search(params)
      # Expect variable to equal flashcard2
      expect(result).to include(flashcard2)
    end

    it "returns all flashcards if params[:front] does not exist" do 
      # Persist flashcard1
      flashcard1 = Flashcard.create!(front: "Hello", back: "Oi")
      # Persist flashcard2
      flashcard2 = Flashcard.create!(front: "Goodbye", back: "Tchau")
      # Run query that matches flashcard2 and assign result to variable
      params = { }
      result = Flashcard.search(params)
      # Expect variable to equal flashcard2
      expect(result).to match_array(Flashcard.all)
    end 
  end 
end
