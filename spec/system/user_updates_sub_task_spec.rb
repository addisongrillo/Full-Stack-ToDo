require "rails_helper"
 
RSpec.describe "sub_task update", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
  end
  context "when the sub_task is incomplete" do
    it "marks the sub_task complete" do
      task = Task.create(description: "Learn Rails", user: user)
      sub_task = task.sub_tasks.create(description: "Learn Models", completed: false)
      visit task_sub_tasks_path(task)
 
      within 'tbody' do
        click_button "Mark Complete"
      end
 
      expect(page).to have_text("SubTask was successfully updated")
      within 'tbody' do
        expect(page).to have_selector(:button, "Mark Incomplete" )
      end
    end
  end
  context "when the sub_task is complete" do
    it "marks the sub_task complete" do
      task = Task.create(description: "Learn Rails", user: user)
      sub_task = task.sub_tasks.create(description: "Learn Models", completed: true)
      visit task_sub_tasks_path(task)
 
      within 'tbody' do
        click_button "Mark Incomplete"
      end
 
      expect(page).to have_text("SubTask was successfully updated")
      within 'tbody' do
        expect(page).to have_selector(:button, "Mark Complete" )
      end
    end
  end
end
