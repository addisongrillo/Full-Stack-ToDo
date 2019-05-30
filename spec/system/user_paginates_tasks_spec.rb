require "rails_helper"
 
RSpec.describe "paginating tasks", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    sign_in(user)
  end
  context "when the user visits the root_path" do
    it "displays the first five tasks" do
      (1..10).each{|n| Task.create(description: "Task #{n}", user: user) }
      visit root_path
 
      expect(page).to have_text("Task 1")
      expect(page).to have_text("Task 2")
      expect(page).to have_text("Task 3")
      expect(page).to have_text("Task 4")
      expect(page).to have_text("Task 5")
      expect(page).to_not have_text("Task 6")
    end
  end
  context "when the user requests the second page" do
    it "displays the next five tasks" do
      (1..10).each{|n| Task.create(description: "Task #{n}", user: user) }
      visit root_path
      click_button("Next")
 
      expect(page).to have_text("Task 6")
      expect(page).to have_text("Task 7")
      expect(page).to have_text("Task 8")
      expect(page).to have_text("Task 9")
      expect(page).to have_text("Task 10")
      expect(page).to_not have_text("Task 5")
    end
    context "when the user requests completed tasks" do
      it "displays the second page of completed tasks" do
        (1..10).each{|n| Task.create(description: "Completed Task #{n}", completed: true, user: user) }
        (1..10).each{|n| Task.create(description: "Pending Task #{n}", completed: false, user: user) }
 
        visit root_path(completed: true)
        click_button("Next")
 
        expect(page).to have_text "Completed Task 6"
        expect(page).to have_text "Completed Task 7"
        expect(page).to have_text "Completed Task 8"
        expect(page).to have_text "Completed Task 9"
        expect(page).to have_text "Completed Task 10"
        expect(page).to_not have_text "Pending Task"
        expect(page).to_not have_text "Completed Task 5"
      end
      context "and the user requests past_due tasks" do
        it "displays the second page of completed past_due tasks" do
          (1..10).each{|n| Task.create(description: "Past Due Completed Task #{n}", completed: true, due_date: Date.yesterday, user: user) }
          (1..10).each{|n| Task.create(description: "Due Soon Completed Task #{n}", completed: true, due_date: Date.tomorrow, user: user) }
          (1..10).each{|n| Task.create(description: "Pending Task #{n}", completed: false) }
 
          visit root_path
          find('#menu-past-due').click
          click_button("Next")
 
          expect(page).to have_text("Past Due Completed Task 6")
          expect(page).to have_text("Past Due Completed Task 7")
          expect(page).to have_text("Past Due Completed Task 8")
          expect(page).to have_text("Past Due Completed Task 9")
          expect(page).to have_text("Past Due Completed Task 10")
          expect(page).to_not have_text("Due Soon Completed Task")
          expect(page).to_not have_text("Pending Task")
        end
      end
    end
  end
end
