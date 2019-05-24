require "rails_helper"
 
RSpec.describe "searching for tasks", type: :system, js: true do
  it "returns case-insentitive, partial matches" do
    Task.create(description: "Learn Models")
    Task.create(description: "Learn Controllers")
    Task.create(description: "Learn Views")
 
    visit root_path
    fill_in "term", with: "mOd\n"
 
    expect(page).to have_text("Learn Models")
    expect(page).to_not have_text("Learn Controllers")
    expect(page).to_not have_text("Learn Views")
  end
  context "when other filters are active" do
    it "only returns filtered matches" do
      Task.create(description: "Learn Rails Pending Due Soon", completed: false, due_date: Date.tomorrow)
      Task.create(description: "Learn React Pending Due Soon", completed: false, due_date: Date.tomorrow)
      Task.create(description: "Learn Rails Completed Due Soon", completed: true, due_date: Date.tomorrow)
      Task.create(description: "Learn React Completed Due Soon", completed: true, due_date: Date.tomorrow)
      Task.create(description: "Learn Rails Pending Past Due", completed: false, due_date: Date.yesterday)
      Task.create(description: "Learn React Pending Past Due", completed: false, due_date: Date.yesterday)
      Task.create(description: "Learn Rails Completed Past Due", completed: true, due_date: Date.yesterday)
      Task.create(description: "Learn React Completed Past Due", completed: true, due_date: Date.yesterday)
 
      visit root_path(status: "completed")
      find('#menu-due-soon').click
      fill_in "term", with: "rails\n"
 
      expect(page).to have_text "Learn Rails Completed Due Soon"
      expect(page).to_not have_text "Learn React"
      expect(page).to_not have_text "Learn Rails Completed Past Due"
      expect(page).to_not have_text "Learn Rails Pending"
    end
  end
end
