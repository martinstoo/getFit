require "test_helper"

class Coach::TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training = coach_trainings(:one)
  end

  test "should get index" do
    get coach_trainings_url
    assert_response :success
  end

  test "should get new" do
    get new_coach_training_url
    assert_response :success
  end

  test "should create coach_training" do
    assert_difference("Coach::Training.count") do
      post coach_trainings_url, params: { coach_training: { benutzer_id: @training.benutzer_id, description: @training.description, title: @training.title } }
    end

    assert_redirected_to coach_training_url(Coach::Training.last)
  end

  test "should show coach_training" do
    get coach_training_url(@training)
    assert_response :success
  end

  test "should get edit" do
    get edit_coach_training_url(@training)
    assert_response :success
  end

  test "should update coach_training" do
    patch coach_training_url(@training), params: { coach_training: { benutzer_id: @training.benutzer_id, description: @training.description, title: @training.title } }
    assert_redirected_to coach_training_url(@training)
  end

  test "should destroy coach_training" do
    assert_difference("Coach::Training.count", -1) do
      delete coach_training_url(@training)
    end

    assert_redirected_to coach_trainings_url
  end
end
