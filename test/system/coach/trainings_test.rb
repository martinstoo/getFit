require "application_system_test_case"

class Coach::TrainingsTest < ApplicationSystemTestCase
  setup do
    @coach_training = coach_trainings(:one)
  end

  test "visiting the index" do
    visit coach_trainings_url
    assert_selector "h1", text: "Trainings"
  end

  test "should create training" do
    visit coach_trainings_url
    click_on "New training"

    fill_in "Benutzer", with: @coach_training.benutzer_id
    fill_in "Description", with: @coach_training.description
    fill_in "Title", with: @coach_training.title
    click_on "Create Training"

    assert_text "Training was successfully created"
    click_on "Back"
  end

  test "should update Training" do
    visit coach_training_url(@coach_training)
    click_on "Edit this training", match: :first

    fill_in "Benutzer", with: @coach_training.benutzer_id
    fill_in "Description", with: @coach_training.description
    fill_in "Title", with: @coach_training.title
    click_on "Update Training"

    assert_text "Training was successfully updated"
    click_on "Back"
  end

  test "should destroy Training" do
    visit coach_training_url(@coach_training)
    click_on "Destroy this training", match: :first

    assert_text "Training was successfully destroyed"
  end
end
