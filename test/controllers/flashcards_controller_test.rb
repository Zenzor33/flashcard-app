require "test_helper"

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get flashcard" do
    #Create a user
    user = User.create!(email: 'test99999@example.com', password: 'password', password_confirmation: 'password')
    #Sign in the user
    sign_in user 
    #Make a request to the flashcards controller
    get flashcards_url

    assert_response :success
  end
end
