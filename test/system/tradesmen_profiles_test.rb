require "application_system_test_case"

class TradesmenProfilesTest < ApplicationSystemTestCase
  setup do
    @tradesmen_profile = tradesmen_profiles(:one)
  end

  test "visiting the index" do
    visit tradesmen_profiles_url
    assert_selector "h1", text: "Tradesmen Profiles"
  end

  test "creating a Tradesmen profile" do
    visit tradesmen_profiles_url
    click_on "New Tradesmen Profile"

    fill_in "Description", with: @tradesmen_profile.description
    fill_in "Name", with: @tradesmen_profile.name
    fill_in "Tradesmen trades", with: @tradesmen_profile.tradesmen_trades
    click_on "Create Tradesmen profile"

    assert_text "Tradesmen profile was successfully created"
    click_on "Back"
  end

  test "updating a Tradesmen profile" do
    visit tradesmen_profiles_url
    click_on "Edit", match: :first

    fill_in "Description", with: @tradesmen_profile.description
    fill_in "Name", with: @tradesmen_profile.name
    fill_in "Tradesmen trades", with: @tradesmen_profile.tradesmen_trades
    click_on "Update Tradesmen profile"

    assert_text "Tradesmen profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Tradesmen profile" do
    visit tradesmen_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tradesmen profile was successfully destroyed"
  end
end
