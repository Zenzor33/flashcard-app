require 'rails_helper'

RSpec.feature "Flashcards", type: :feature do

  let(:user){ FactoryBot.create(:user) }
  let!(:flashcards) { FactoryBot.create_list(:flashcard, 3) }
  before { sign_in user} 
    
  scenario "New user signs in and adds a flashcard to their deck" do 
    flashcard = Flashcard.first
    visit flashcards_path
    
    expect {
      within("turbo-frame#flashcard_#{flashcard.id}") do
        find("form.button_to").click_button 'Add to Deck'
      end
    }.to change(user.deck.deck_flashcards, :count).by(1)
  end 

  scenario "New user signs in and removes a flashcard from their deck" do 
    flashcard = Flashcard.first
    user.deck.add_flashcard(flashcard)
    visit flashcards_path

    expect {
      within("turbo-frame#flashcard_#{flashcard.id}") do
        find("form.button_to").click_button 'Remove from Deck'
      end
    }.to change(user.deck.deck_flashcards, :count).by(-1)
  end 
end
