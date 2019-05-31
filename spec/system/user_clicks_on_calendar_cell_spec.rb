require "rails_helper"
 
RSpec.describe "clicking on a calendar cell", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
  end
  context "when a task is due that day" do
    it "displays a link to the task" do
      task = user.tasks.create(description: "Due Today", due_date: Date.today)
      visit calendar_path
 
      find("#day-#{Date.today}").click
      click_link(task.description)
 
      expect(page.current_path).to eq(task_sub_tasks_path(task))
    end
  end
  context "when no task is due that day" do
    it "displays a message that no tasks are due" do
      visit calendar_path
 
      find("#day-#{Date.today}").click
 
      expect(page).to have_text("No tasks due today")
    end
  end
end
