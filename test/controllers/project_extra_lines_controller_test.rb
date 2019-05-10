require 'test_helper'

class ProjectExtraLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_extra_line = project_extra_lines(:one)
  end

  test "should get index" do
    get project_extra_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_project_extra_line_url
    assert_response :success
  end

  test "should create project_extra_line" do
    assert_difference('ProjectExtraLine.count') do
      post project_extra_lines_url, params: { project_extra_line: { extra_id: @project_extra_line.extra_id, project_id: @project_extra_line.project_id, quantity: @project_extra_line.quantity } }
    end

    assert_redirected_to project_extra_line_url(ProjectExtraLine.last)
  end

  test "should show project_extra_line" do
    get project_extra_line_url(@project_extra_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_extra_line_url(@project_extra_line)
    assert_response :success
  end

  test "should update project_extra_line" do
    patch project_extra_line_url(@project_extra_line), params: { project_extra_line: { extra_id: @project_extra_line.extra_id, project_id: @project_extra_line.project_id, quantity: @project_extra_line.quantity } }
    assert_redirected_to project_extra_line_url(@project_extra_line)
  end

  test "should destroy project_extra_line" do
    assert_difference('ProjectExtraLine.count', -1) do
      delete project_extra_line_url(@project_extra_line)
    end

    assert_redirected_to project_extra_lines_url
  end
end
