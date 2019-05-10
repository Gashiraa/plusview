require "application_system_test_case"

class ExtrasTest < ApplicationSystemTestCase
  setup do
    @extra = extras(:one)
  end

  test "visiting the index" do
    visit extras_url
    assert_selector "h1", text: "Extras"
  end

  test "creating a Extra" do
    visit extras_url
    click_on "New Extra"

    fill_in "Display name", with: @extra.display_name
    fill_in "Name", with: @extra.name
    fill_in "Unit", with: @extra.unit
    fill_in "Unit price", with: @extra.unit_price
    click_on "Create Extra"

    assert_text "Extra was successfully created"
    click_on "Back"
  end

  test "updating a Extra" do
    visit extras_url
    click_on "Edit", match: :first

    fill_in "Display name", with: @extra.display_name
    fill_in "Name", with: @extra.name
    fill_in "Unit", with: @extra.unit
    fill_in "Unit price", with: @extra.unit_price
    click_on "Update Extra"

    assert_text "Extra was successfully updated"
    click_on "Back"
  end

  test "destroying a Extra" do
    visit extras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Extra was successfully destroyed"
  end
end
