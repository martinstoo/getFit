require "test_helper"

class Student::TrainingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_trainings_index_url
    assert_response :success
  end

  test "should get show" do
    get student_trainings_show_url
    assert_response :success
  end
end
