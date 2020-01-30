require "application_system_test_case"

class CustomThreadsTest < ApplicationSystemTestCase
  setup do
    @custom_thread = custom_threads(:one)
  end

  test "visiting the index" do
    visit custom_threads_url
    assert_selector "h1", text: "Custom Threads"
  end

  test "creating a Custom thread" do
    visit custom_threads_url
    click_on "New Custom Thread"

    fill_in "Project", with: @custom_thread.project_id
    fill_in "Title", with: @custom_thread.title
    click_on "Create Custom thread"

    assert_text "Custom thread was successfully created"
    click_on "Back"
  end

  test "updating a Custom thread" do
    visit custom_threads_url
    click_on "Edit", match: :first

    fill_in "Project", with: @custom_thread.project_id
    fill_in "Title", with: @custom_thread.title
    click_on "Update Custom thread"

    assert_text "Custom thread was successfully updated"
    click_on "Back"
  end

  test "destroying a Custom thread" do
    visit custom_threads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Custom thread was successfully destroyed"
  end
end
