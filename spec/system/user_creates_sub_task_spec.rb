require "rails_helper"
 
RSpec.describe "sub_task creation", type: :system, js: true do
  context "when the sub_task description is present" do
    it "displays a success message" do
      task = Task.create(description: "Learn Rails")
      visit task_sub_tasks_path(task)
 
      fill_in "sub_task_description", with: "Learn Models"
      click_button "Create Sub task"
 
      expect(page).to have_text("SubTask was successfully created")
    end
  end
  context "when the sub_task description is not present" do
    it "displays an error message" do
      task = Task.create(description: "Learn Rails")
      visit task_sub_tasks_path(task)
 
      click_button "Create Sub task"
 
      expect(page).to have_text("Description can't be blank")
    end
  end
end
