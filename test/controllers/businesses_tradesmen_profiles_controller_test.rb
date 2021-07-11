require "test_helper"

class BusinessesTradesmenProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @businesses_tradesmen_profile = businesses_tradesmen_profiles(:one)
  end

  test "should get index" do
    get businesses_tradesmen_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_businesses_tradesmen_profile_url
    assert_response :success
  end

  test "should create businesses_tradesmen_profile" do
    assert_difference('BusinessesTradesmenProfile.count') do
      post businesses_tradesmen_profiles_url, params: { businesses_tradesmen_profile: { business_id: @businesses_tradesmen_profile.business_id, tradesmen_profile_id: @businesses_tradesmen_profile.tradesmen_profile_id } }
    end

    assert_redirected_to businesses_tradesmen_profile_url(BusinessesTradesmenProfile.last)
  end

  test "should show businesses_tradesmen_profile" do
    get businesses_tradesmen_profile_url(@businesses_tradesmen_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_businesses_tradesmen_profile_url(@businesses_tradesmen_profile)
    assert_response :success
  end

  test "should update businesses_tradesmen_profile" do
    patch businesses_tradesmen_profile_url(@businesses_tradesmen_profile), params: { businesses_tradesmen_profile: { business_id: @businesses_tradesmen_profile.business_id, tradesmen_profile_id: @businesses_tradesmen_profile.tradesmen_profile_id } }
    assert_redirected_to businesses_tradesmen_profile_url(@businesses_tradesmen_profile)
  end

  test "should destroy businesses_tradesmen_profile" do
    assert_difference('BusinessesTradesmenProfile.count', -1) do
      delete businesses_tradesmen_profile_url(@businesses_tradesmen_profile)
    end

    assert_redirected_to businesses_tradesmen_profiles_url
  end
end
