require "test_helper"

class AreaTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @area_type = area_types(:one)
  end

  test "should get index" do
    get area_types_url
    assert_response :success
  end

  test "should get new" do
    get new_area_type_url
    assert_response :success
  end

  test "should create area_type" do
    assert_difference("AreaType.count") do
      post area_types_url, params: { area_type: { name: @area_type.name, user_id: @area_type.user_id } }
    end

    assert_redirected_to area_type_url(AreaType.last)
  end

  test "should show area_type" do
    get area_type_url(@area_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_area_type_url(@area_type)
    assert_response :success
  end

  test "should update area_type" do
    patch area_type_url(@area_type), params: { area_type: { name: @area_type.name, user_id: @area_type.user_id } }
    assert_redirected_to area_type_url(@area_type)
  end

  test "should destroy area_type" do
    assert_difference("AreaType.count", -1) do
      delete area_type_url(@area_type)
    end

    assert_redirected_to area_types_url
  end
end
