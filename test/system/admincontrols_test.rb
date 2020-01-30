require "application_system_test_case"

class AdmincontrolsTest < ApplicationSystemTestCase
  setup do
    @admincontrol = admincontrols(:one)
  end

  test "visiting the index" do
    visit admincontrols_url
    assert_selector "h1", text: "Admincontrols"
  end

  test "creating a Admincontrol" do
    visit admincontrols_url
    click_on "New Admincontrol"

    click_on "Create Admincontrol"

    assert_text "Admincontrol was successfully created"
    click_on "Back"
  end

  test "updating a Admincontrol" do
    visit admincontrols_url
    click_on "Edit", match: :first

    click_on "Update Admincontrol"

    assert_text "Admincontrol was successfully updated"
    click_on "Back"
  end

  test "destroying a Admincontrol" do
    visit admincontrols_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admincontrol was successfully destroyed"
  end
end
