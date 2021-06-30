require "test_helper"

class TradesmenProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tradesmen_profile = tradesmen_profiles(:one)
  end

  test "should get index" do
    get tradesmen_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_tradesmen_profile_url
    assert_response :success
  end

  test "should create tradesmen_profile" do
    assert_difference('TradesmenProfile.count') do
      post tradesmen_profiles_url, params: { tradesmen_profile: { description: @tradesmen_profile.description, name: @tradesmen_profile.name, tradesmen_trades: @tradesmen_profile.tradesmen_trades } }
    end

    assert_redirected_to tradesmen_profile_url(TradesmenProfile.last)
  end

  test "should show tradesmen_profile" do
    get tradesmen_profile_url(@tradesmen_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_tradesmen_profile_url(@tradesmen_profile)
    assert_response :success
  end

  test "should update tradesmen_profile" do
    patch tradesmen_profile_url(@tradesmen_profile), params: { tradesmen_profile: { description: @tradesmen_profile.description, name: @tradesmen_profile.name, tradesmen_trades: @tradesmen_profile.tradesmen_trades } }
    assert_redirected_to tradesmen_profile_url(@tradesmen_profile)
  end

  test "should destroy tradesmen_profile" do
    assert_difference('TradesmenProfile.count', -1) do
      delete tradesmen_profile_url(@tradesmen_profile)
    end

    assert_redirected_to tradesmen_profiles_url
  end
end
