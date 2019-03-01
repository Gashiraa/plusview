require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service = services(:one)
  end

  test "should get index" do
    get services_url
    assert_response :success
  end

  test "should get new" do
    get new_service_url
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post services_url, params: { service: { coefficient: @service.coefficient, comment: @service.comment, customer_id: @service.customer_id, date: @service.date, duration: @service.duration, hourly_rate: @service.hourly_rate, invoice_id: @service.invoice_id, name: @service.name, project_id: @service.project_id, quotation_id: @service.quotation_id, status: @service.status, total_cost: @service.total_cost, tva_rate: @service.tva_rate } }
    end

    assert_redirected_to service_url(Service.last)
  end

  test "should show service" do
    get service_url(@service)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_url(@service)
    assert_response :success
  end

  test "should update service" do
    patch service_url(@service), params: { service: { coefficient: @service.coefficient, comment: @service.comment, customer_id: @service.customer_id, date: @service.date, duration: @service.duration, hourly_rate: @service.hourly_rate, invoice_id: @service.invoice_id, name: @service.name, project_id: @service.project_id, quotation_id: @service.quotation_id, status: @service.status, total_cost: @service.total_cost, tva_rate: @service.tva_rate } }
    assert_redirected_to service_url(@service)
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete service_url(@service)
    end

    assert_redirected_to services_url
  end
end
