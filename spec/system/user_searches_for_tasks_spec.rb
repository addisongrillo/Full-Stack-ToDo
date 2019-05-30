require "rails_helper"
 
RSpec.describe "searching for tasks", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
  end
  it "returns case-insentitive, partial matches" do
    Task.create(description: "Learn Models", user: user)
    Task.create(description: "Learn Controllers", user: user)
    Task.create(description: "Learn Views", user: user)
 
    visit root_path
    search_bar = find("#term")
    search_bar.send_keys "m"
    sleep 0.1
    search_bar.send_keys "O"
    sleep 0.1
    search_bar.send_keys "d"

    expect(page).to have_text("Learn Models")
    expect(page).to_not have_text("Learn Controllers")
    expect(page).to_not have_text("Learn Views")
  end
  context "when other filters are active" do
    it "only returns filtered matches" do
      Task.create(description: "Learn Rails Pending Due Soon", completed: false, due_date: Date.tomorrow, user: user)
      Task.create(description: "Learn React Pending Due Soon", completed: false, due_date: Date.tomorrow, user: user)
      Task.create(description: "Learn Rails Completed Due Soon", completed: true, due_date: Date.tomorrow, user: user)
      Task.create(description: "Learn React Completed Due Soon", completed: true, due_date: Date.tomorrow, user: user)
      Task.create(description: "Learn Rails Pending Past Due", completed: false, due_date: Date.yesterday, user: user)
      Task.create(description: "Learn React Pending Past Due", completed: false, due_date: Date.yesterday, user: user)
      Task.create(description: "Learn Rails Completed Past Due", completed: true, due_date: Date.yesterday, user: user)
      Task.create(description: "Learn React Completed Past Due", completed: true, due_date: Date.yesterday, user: user)
 
      visit root_path(status: "completed")
      find('#menu-due-soon').click
      search_bar = find("#term")
 
      search_bar.send_keys "r"
      sleep 0.1
      search_bar.send_keys "a"
      sleep 0.1
      search_bar.send_keys "i"
      sleep 0.1
      search_bar.send_keys "l"
      sleep 0.1
      search_bar.send_keys "s"
 
      expect(page).to have_text "Learn Rails Completed Due Soon"
      expect(page).to_not have_text "Learn React"
      expect(page).to_not have_text "Learn Rails Completed Past Due"
      expect(page).to_not have_text "Learn Rails Pending"
    end
  end
end
