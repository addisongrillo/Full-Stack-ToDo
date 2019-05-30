require "rails_helper"
 
RSpec.describe "task update", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
  end
  context "when the task is incomplete" do
    it "marks the task complete" do
      task = Task.create(description: "Learn Rails", completed: false, user: user)
      visit task_sub_tasks_path(task)
      click_button "Mark Complete"

      expect(page).to have_text("Task was successfully updated")
      expect(page).to have_selector(:button, "Mark Incomplete" )
    end
  end
  context "when the task is complete" do
    it "marks the task incomplete" do
      task = Task.create(description: "Learn Rails", completed: true, user: user)
      visit task_sub_tasks_path(task)
      click_button "Mark Incomplete"

      expect(page).to have_text("Task was successfully updated")
      expect(page).to have_selector(:button, "Mark Complete" )
    end
  end
end
