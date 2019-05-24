require "rails_helper"

RSpec.describe "task creation", type: :system, js: true do
  before do
    visit root_path
  end
  context "when the task description is present" do
    it "displays a success message" do
      fill_in "task_description", with: "Learn Rails"
      click_button "Create Task"

      expect(page).to have_text "Task was successfully created."
    end
  end
  context "when the task description is not present" do
    it "displays an error message" do
      click_button "Create Task"

      expect(page).to have_text "Description can't be blank"
    end
  end
end
