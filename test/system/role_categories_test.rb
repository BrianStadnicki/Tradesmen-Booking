require "application_system_test_case"

class RoleCategoriesTest < ApplicationSystemTestCase
  setup do
    @role_category = role_categories(:one)
  end

  test "visiting the index" do
    visit role_categories_url
    assert_selector "h1", text: "Role Categories"
  end

  test "creating a Role category" do
    visit role_categories_url
    click_on "New Role Category"

    fill_in "Description", with: @role_category.description
    fill_in "Name", with: @role_category.name
    click_on "Create Role category"

    assert_text "Role category was successfully created"
    click_on "Back"
  end

  test "updating a Role category" do
    visit role_categories_url
    click_on "Edit", match: :first

    fill_in "Description", with: @role_category.description
    fill_in "Name", with: @role_category.name
    click_on "Update Role category"

    assert_text "Role category was successfully updated"
    click_on "Back"
  end

  test "destroying a Role category" do
    visit role_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role category was successfully destroyed"
  end
end
