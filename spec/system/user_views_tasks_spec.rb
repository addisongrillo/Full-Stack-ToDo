require "rails_helper"

RSpec.describe "viewing tasks", type: :system, js: true do
  before do
    Task.create(description: "Completed Task", completed: true)
    Task.create(description: "Pending Task", completed: false)
  end
  context "when the user requests completed tasks" do
    it "only displays completed tasks" do
      visit root_path(status: "completed")

      expect(page).to have_text "Completed Task"
      expect(page).to_not have_text "Pending Task"
    end
  end
  context "when the user requests pending tasks" do
    it "only displays pending tasks" do
      visit root_path(status: "pending")

      expect(page).to have_text "Pending Task"
      expect(page).to_not have_text "Completed Task"
    end
  end
  context "when the user requests all tasks" do
    it "displays both pending and completed tasks" do
      visit root_path

      expect(page).to have_text "Pending Task"
      expect(page).to have_text "Completed Task"
    end
  end
end
