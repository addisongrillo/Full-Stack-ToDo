require "rails_helper"

RSpec.describe "task destruction", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
  end
  it "destroys the task" do
    task = Task.create(description: "Learn Rails", completed: false, user: user)
    visit task_sub_tasks_path(task)
    accept_confirm do
      click_link "Destroy"
    end

    expect(page).to have_text("Task was successfully destroyed")
  end
  it "redirects to the root path" do
    task = Task.create(description: "Learn Rails", completed: false, user: user)
    visit task_sub_tasks_path(task)
    accept_confirm do
      click_link "Destroy"
    end

    expect(page.current_path).to eq(root_path)
  end
end
