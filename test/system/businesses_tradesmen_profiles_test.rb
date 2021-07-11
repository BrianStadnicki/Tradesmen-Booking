require "application_system_test_case"

class BusinessesTradesmenProfilesTest < ApplicationSystemTestCase
  setup do
    @businesses_tradesmen_profile = businesses_tradesmen_profiles(:one)
  end

  test "visiting the index" do
    visit businesses_tradesmen_profiles_url
    assert_selector "h1", text: "Businesses Tradesmen Profiles"
  end

  test "creating a Businesses tradesmen profile" do
    visit businesses_tradesmen_profiles_url
    click_on "New Businesses Tradesmen Profile"

    fill_in "Business", with: @businesses_tradesmen_profile.business_id
    fill_in "Tradesmen profile", with: @businesses_tradesmen_profile.tradesmen_profile_id
    click_on "Create Businesses tradesmen profile"

    assert_text "Businesses tradesmen profile was successfully created"
    click_on "Back"
  end

  test "updating a Businesses tradesmen profile" do
    visit businesses_tradesmen_profiles_url
    click_on "Edit", match: :first

    fill_in "Business", with: @businesses_tradesmen_profile.business_id
    fill_in "Tradesmen profile", with: @businesses_tradesmen_profile.tradesmen_profile_id
    click_on "Update Businesses tradesmen profile"

    assert_text "Businesses tradesmen profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Businesses tradesmen profile" do
    visit businesses_tradesmen_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Businesses tradesmen profile was successfully destroyed"
  end
end
