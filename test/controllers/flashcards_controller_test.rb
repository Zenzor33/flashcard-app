require "test_helper"

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do 
    #Create a user
    user = User.create!(email: 'test99999@example.com', password: 'password', password_confirmation: 'password')
    #Sign in the user
    sign_in user 
  end 

  test "should get flashcards_url" do

    #Make a request to the flashcards controller
    get flashcards_url

    assert_response :success
  end

  #Should show flashcard page for @flashcard
  test "should show flashcard" do 
    #Make a request to flashcards#show
    @flashcard = Flashcard.create!(front: "Hello World",back: "Ola Mundo")
    get flashcard_path(@flashcard)

    assert_response :success
  end 

  test "should redirect to rooth_path and display alert message if flashcard not found" do 
    #Make a request to flashcards#show
    get flashcard_url(id: -1)

    assert_redirected_to root_path
    assert_equal 'Flashcard not found', flash[:alert]
  end 
end
