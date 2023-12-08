require 'rails_helper'

RSpec.feature "Flashcards", type: :feature do
  scenario "New user signs in and adds a flashcard to their deck" do 
    user = FactoryBot.create(:user)
    
    # Assuming flashcards are listed with an 'Add to Deck' button
    first_flashcard = FactoryBot.create(:flashcard)
    second_flashcard = FactoryBot.create(:flashcard)
    third_flashcard = FactoryBot.create(:flashcard)
    
    visit new_user_session_path 
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button "Log in"
    # visit flashcards_path 

    expect {
      within("turbo-frame#flashcard_#{first_flashcard.id}") do
        find("form.button_to").click_button 'Add to Deck'
      end
    }.to change(user.deck.deck_flashcards, :count).by(1)
  end 

  scenario "New user signs in and removes a flashcard from their deck" do 
    user = FactoryBot.create(:user)
    
    # Assuming flashcards are listed with an 'Add to Deck' button
    first_flashcard = FactoryBot.create(:flashcard)
    second_flashcard = FactoryBot.create(:flashcard)
    third_flashcard = FactoryBot.create(:flashcard)

    user.deck.add_flashcard(first_flashcard)

    visit new_user_session_path 
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button "Log in"
    # visit flashcards_path 

    expect {
      within("turbo-frame#flashcard_#{first_flashcard.id}") do
        find("form.button_to").click_button 'Remove from Deck'
      end
    }.to change(user.deck.deck_flashcards, :count).by(-1)
    
  end 
end
