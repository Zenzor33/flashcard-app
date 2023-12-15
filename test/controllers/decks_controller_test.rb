require "test_helper"

class DecksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do 
    #Create a user
    @user = User.create!(email: 'test99999@example.com', password: 'password', password_confirmation: 'password')
    #Sign in the user
    sign_in @user 
  end 

  test "User has a deck" do
    assert_not_nil @user.deck
  end

  test "Should redirect to rooth path with flash alert if deck is empty" do 
    get check_deck_flashcards_user_decks_path(@user)

    assert_redirected_to root_path
    assert_equal "Please add flashcards to your deck to start studying.", flash[:alert]
  end 

  test "Should redirect to study page if deck flashcards exist" do 
    flashcard = create_flashcard
    add_flashcard_to_deck(flashcard)

    get check_deck_flashcards_user_decks_path(@user)
    first_deck_flashcard_id = @user.deck.deck_flashcards.order(id: :asc).first.id

    assert_redirected_to user_deck_study_deck_flashcard_path(@user, @user.deck, first_deck_flashcard_id)
  end 

  test "show action" do
    flashcard = create_flashcard
    add_flashcard_to_deck(flashcard)
    get user_deck_path(@user, @user.deck)

    assert_response :success
  end 

  test "Should add flashcard to deck" do 
    flashcard = create_flashcard
    assert_difference('@user.deck.deck_flashcards.count', 1) do 
      post add_flashcard_user_deck_path(@user, @user.deck), params: {flashcard_id: flashcard.id}
    end
  end

  test "Should add flashcard to deck" do 
    flashcard = create_flashcard
    assert_difference('@user.deck.deck_flashcards.count', 1) do 
      post add_flashcard_user_deck_path(@user, @user.deck), params: {flashcard_id: flashcard.id}
    end
  end

  private

  def create_flashcard
    Flashcard.create!(front: "Hello World", back: "Ola Mundo")
  end

  def add_flashcard_to_deck(flashcard)
    @user.deck.deck_flashcards.create!(  
      flashcard_id: flashcard.id,
      correct_count: 0,
      incorrect_count: 0,
      accuracy: 0.0,
      category: "new",
      attempts: 0
    )
  end

end
