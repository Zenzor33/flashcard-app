require 'rails_helper'

RSpec.describe "Flashcards", type: :request do

  let!(:user) { FactoryBot.create(:user) }
  let!(:flashcard) { FactoryBot.create(:flashcard) }

  before { sign_in user }

  describe "GET /index" do
    it "returns HTTP success" do 
      get flashcards_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do 
    context "With valid Flashcard ID" do 
      it "returns HTTP success" do 
        get flashcard_path(flashcard)
        expect(response).to have_http_status(:success)
      end
    end

    context "With an invalid Flashcard ID" do 
      it "Returns 302 redirect" do 
        get flashcard_path('invalid flashcard id')
        expect(response).to have_http_status(302)
      end 
    end 
  end   

  context "When user is unauthenticated" do
    before {sign_out user}
    it "redirects to sign_in page" do 
      get flashcards_path 
      expect(response).to have_http_status(302)
      expect(response).to redirect_to "/users/sign_in"
    end 
  end
end
