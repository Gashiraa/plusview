require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
  end

  test "visiting the index" do
    visit customers_url
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_url
    click_on "New Customer"

    fill_in "Country", with: @customer.country
    fill_in "Cp", with: @customer.cp
    fill_in "Locality", with: @customer.locality
    fill_in "Mail", with: @customer.mail
    fill_in "Name", with: @customer.name
    fill_in "Number", with: @customer.number
    fill_in "Street", with: @customer.street
    fill_in "Tva record", with: @customer.tva_record
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit customers_url
    click_on "Edit", match: :first

    fill_in "Country", with: @customer.country
    fill_in "Cp", with: @customer.cp
    fill_in "Locality", with: @customer.locality
    fill_in "Mail", with: @customer.mail
    fill_in "Name", with: @customer.name
    fill_in "Number", with: @customer.number
    fill_in "Street", with: @customer.street
    fill_in "Tva record", with: @customer.tva_record
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    visit customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer was successfully destroyed"
  end
end
