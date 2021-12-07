require "application_system_test_case"

class SelfTestsTest < ApplicationSystemTestCase
  setup do
    @self_test = self_tests(:one)
  end

  test "visiting the index" do
    visit self_tests_url
    assert_selector "h1", text: "Self Tests"
  end

  test "creating a Self test" do
    visit self_tests_url
    click_on "New Self Test"

    fill_in "Done at", with: @self_test.done_at
    fill_in "Ip reference", with: @self_test.ip_reference
    check "Is positive" if @self_test.is_positive
    click_on "Create Self test"

    assert_text "Self test was successfully created"
    click_on "Back"
  end

  test "updating a Self test" do
    visit self_tests_url
    click_on "Edit", match: :first

    fill_in "Done at", with: @self_test.done_at
    fill_in "Ip reference", with: @self_test.ip_reference
    check "Is positive" if @self_test.is_positive
    click_on "Update Self test"

    assert_text "Self test was successfully updated"
    click_on "Back"
  end

  test "destroying a Self test" do
    visit self_tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Self test was successfully destroyed"
  end
end
