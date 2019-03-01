require "application_system_test_case"

class ServicesTest < ApplicationSystemTestCase
  setup do
    @service = services(:one)
  end

  test "visiting the index" do
    visit services_url
    assert_selector "h1", text: "Services"
  end

  test "creating a Service" do
    visit services_url
    click_on "New Service"

    fill_in "Coefficient", with: @service.coefficient
    fill_in "Comment", with: @service.comment
    fill_in "Customer", with: @service.customer_id
    fill_in "Date", with: @service.date
    fill_in "Duration", with: @service.duration
    fill_in "Hourly rate", with: @service.hourly_rate
    fill_in "Invoice", with: @service.invoice_id
    fill_in "Name", with: @service.name
    fill_in "Project", with: @service.project_id
    fill_in "Quotation", with: @service.quotation_id
    fill_in "Status", with: @service.status
    fill_in "Total cost", with: @service.total_cost
    fill_in "Tva rate", with: @service.tva_rate
    click_on "Create Service"

    assert_text "Service was successfully created"
    click_on "Back"
  end

  test "updating a Service" do
    visit services_url
    click_on "Edit", match: :first

    fill_in "Coefficient", with: @service.coefficient
    fill_in "Comment", with: @service.comment
    fill_in "Customer", with: @service.customer_id
    fill_in "Date", with: @service.date
    fill_in "Duration", with: @service.duration
    fill_in "Hourly rate", with: @service.hourly_rate
    fill_in "Invoice", with: @service.invoice_id
    fill_in "Name", with: @service.name
    fill_in "Project", with: @service.project_id
    fill_in "Quotation", with: @service.quotation_id
    fill_in "Status", with: @service.status
    fill_in "Total cost", with: @service.total_cost
    fill_in "Tva rate", with: @service.tva_rate
    click_on "Update Service"

    assert_text "Service was successfully updated"
    click_on "Back"
  end

  test "destroying a Service" do
    visit services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service was successfully destroyed"
  end
end
