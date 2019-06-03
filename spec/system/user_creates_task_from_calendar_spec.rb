require "rails_helper"
 
RSpec.describe "creating a task from the calendar", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
    visit calendar_path
  end
  context "when the description is present" do
    it "adds a link to the task" do
      find("#day-#{Date.today}").click
      fill_in "task_description", with: "Learn React on Rails"
      click_button "Create Task"
 
      expect(page).to have_link "Learn React on Rails"
    end
  end
  context "when the description is absent" do
    it "displays an error message" do
      find("#day-#{Date.today}").click
      click_button "Create Task"
 
      expect(page).to have_text("Description can't be blank")
    end
  end
end
