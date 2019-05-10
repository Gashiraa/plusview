require "application_system_test_case"

class ProjectExtraLinesTest < ApplicationSystemTestCase
  setup do
    @project_extra_line = project_extra_lines(:one)
  end

  test "visiting the index" do
    visit project_extra_lines_url
    assert_selector "h1", text: "Project Extra Lines"
  end

  test "creating a Project extra line" do
    visit project_extra_lines_url
    click_on "New Project Extra Line"

    fill_in "Extra", with: @project_extra_line.extra_id
    fill_in "Project", with: @project_extra_line.project_id
    fill_in "Quantity", with: @project_extra_line.quantity
    click_on "Create Project extra line"

    assert_text "Project extra line was successfully created"
    click_on "Back"
  end

  test "updating a Project extra line" do
    visit project_extra_lines_url
    click_on "Edit", match: :first

    fill_in "Extra", with: @project_extra_line.extra_id
    fill_in "Project", with: @project_extra_line.project_id
    fill_in "Quantity", with: @project_extra_line.quantity
    click_on "Update Project extra line"

    assert_text "Project extra line was successfully updated"
    click_on "Back"
  end

  test "destroying a Project extra line" do
    visit project_extra_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project extra line was successfully destroyed"
  end
end
