require "application_system_test_case"

class AreaTypesTest < ApplicationSystemTestCase
  setup do
    @area_type = area_types(:one)
  end

  test "visiting the index" do
    visit area_types_url
    assert_selector "h1", text: "Area types"
  end

  test "should create area type" do
    visit area_types_url
    click_on "New area type"

    fill_in "Name", with: @area_type.name
    fill_in "User", with: @area_type.user_id
    click_on "Create Area type"

    assert_text "Area type was successfully created"
    click_on "Back"
  end

  test "should update Area type" do
    visit area_type_url(@area_type)
    click_on "Edit this area type", match: :first

    fill_in "Name", with: @area_type.name
    fill_in "User", with: @area_type.user_id
    click_on "Update Area type"

    assert_text "Area type was successfully updated"
    click_on "Back"
  end

  test "should destroy Area type" do
    visit area_type_url(@area_type)
    click_on "Destroy this area type", match: :first

    assert_text "Area type was successfully destroyed"
  end
end
