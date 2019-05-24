require "rails_helper"

RSpec.describe "viewing tasks", type: :system, js: true do
  it "displays the tasks ordered by due date, with tasks without due dates last" do
    not_due   = Task.create(description: "Not Due", due_date: nil)
    due_later = Task.create(description: "Due Later", due_date: 10.days.from_now.to_date)
    due_soon  = Task.create(description: "Due Soon", due_date: 3.days.from_now.to_date)
    past_due  = Task.create(description: "Past Due", due_date: 3.days.ago.to_date)
 
    visit root_path
 
    within "tbody tr:nth-child(1)" do
      expect(page).to have_text past_due.description
    end
    within "tbody tr:nth-child(2)" do
      expect(page).to have_text due_soon.description
    end
    within "tbody tr:nth-child(3)" do
      expect(page).to have_text due_later.description
    end
    within "tbody tr:nth-child(4)" do
      expect(page).to have_text not_due.description
    end
  end
  context "when the user requests all tasks" do
    it "displays both pending and completed tasks" do
      Task.create(description: "Completed Task", completed: true)
      Task.create(description: "Pending Task", completed: false)

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
