require "test_helper"

class StudiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get studies_show_url
    assert_response :success
  end

  test "should get update" do
    get studies_update_url
    assert_response :success
  end
end
