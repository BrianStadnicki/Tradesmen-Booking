require "test_helper"

class RoleCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_category = role_categories(:one)
  end

  test "should get index" do
    get role_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_role_category_url
    assert_response :success
  end

  test "should create role_category" do
    assert_difference('RoleCategory.count') do
      post role_categories_url, params: { role_category: { description: @role_category.description, name: @role_category.name } }
    end

    assert_redirected_to role_category_url(RoleCategory.last)
  end

  test "should show role_category" do
    get role_category_url(@role_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_category_url(@role_category)
    assert_response :success
  end

  test "should update role_category" do
    patch role_category_url(@role_category), params: { role_category: { description: @role_category.description, name: @role_category.name } }
    assert_redirected_to role_category_url(@role_category)
  end

  test "should destroy role_category" do
    assert_difference('RoleCategory.count', -1) do
      delete role_category_url(@role_category)
    end

    assert_redirected_to role_categories_url
  end
end
