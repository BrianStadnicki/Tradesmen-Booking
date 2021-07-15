require "test_helper"

class BusinessesTradesmenProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get business_tradesmen_profile_create_url
    assert_response :success
  end

  test "should get destroy" do
    get business_tradesmen_profile_destroy_url
    assert_response :success
  end
end
