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
  context "when a task is past due" do
    it "displays the due_date in red" do
      task = Task.create(description: "past due", due_date: 1.day.ago.to_date)
      visit root_path
 
      color = find("#task_#{task.id} .due_date").native.css_value('background-color')
      expect(color).to eq('rgba(220, 53, 69, 1)')
    end
  end
  context "when a task is due soon" do
    it "displays the due_date in yellow" do
      task = Task.create(description: "due soon", due_date: Date.tomorrow)
      visit root_path
 
      color = find("#task_#{task.id} .due_date").native.css_value('background-color')
      expect(color).to eq('rgba(255, 193, 7, 1)')
    end
  end
  context "when a task is due later" do
    it "displays the due_date in green" do
      task = Task.create(description: "due later", due_date: 10.days.from_now.to_date)
      visit root_path
 
      color = find("#task_#{task.id} .due_date").native.css_value('background-color')
      expect(color).to eq('rgba(40, 167, 69, 1)')
    end
  end
end
