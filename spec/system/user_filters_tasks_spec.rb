require "rails_helper"
 
RSpec.describe "filtering tasks", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  before do
    ["Completed", "Pending"].each do |status|
      Task.create(
        description:  "#{status} Not Due",
        due_date:     nil,
        completed:    status == "Completed",
        user:         user
      )
      Task.create(
        description:  "#{status} Due Later",
        due_date:     10.days.from_now.to_date,
        completed:    status == "Completed",
        user:         user
      )
      Task.create(
        description:  "#{status} Due Soon",
        due_date:     3.days.from_now.to_date,
        completed:    status == "Completed",
        user:         user
      )
      Task.create(
        description:  "#{status} Past Due",
        due_date:     3.days.ago.to_date,
        completed:    status == "Completed",
        user:         user
      )
      sign_in(user)
    end
  end
  context "when the user requests completed tasks" do
    context "and the user requests past_due tasks" do
      it "displays only the completed past_due tasks" do
        visit root_path(status: "completed")
        find('#menu-past-due').click
 
        expect(page).to have_text "Completed Past Due"
        expect(page).to_not have_text "Pending Past Due"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Completed Not Due"
      end
    end
    context "and the user requests due_soon tasks" do
      it "displays only the completed due_soon tasks" do
        visit root_path(status: "completed")
        find('#menu-due-soon').click
 
        expect(page).to have_text "Completed Due Soon"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Completed Past Due"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Completed Not Due"
      end
    end
    context "and the user requests due_later tasks" do
      it "displays only the completed due_later tasks" do
        visit root_path(status: "completed")
        find('#menu-due-later').click
 
        expect(page).to have_text "Completed Due Later"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Completed Past Due"
        expect(page).to_not have_text "Completed Not Due"
      end
    end
    context "and the user requests not_due tasks" do
      it "displays only the completed not_due tasks" do
        visit root_path(status: "completed")
        find('#menu-not-due').click
 
        expect(page).to have_text "Completed Not Due"
        expect(page).to_not have_text "Pending Not Due"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Completed Past Due"
      end
    end
  end
  context "when the user requests pending tasks" do
    context "and the user requests past_due tasks" do
      it "displays only the pending past_due tasks" do
        visit root_path(status: "pending")
        find('#menu-past-due').click
 
        expect(page).to have_text "Pending Past Due"
        expect(page).to_not have_text "Completed Past Due"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Pending Not Due"
      end
    end
    context "and the user requests due_soon tasks" do
      it "displays only the pending due_soon tasks" do
        visit root_path(status: "pending")
        find('#menu-due-soon').click
 
        expect(page).to have_text "Pending Due Soon"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Pending Past Due"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Pending Not Due"
      end
    end
    context "and the user requests due_later tasks" do
      it "displays only the pending due_later tasks" do
        visit root_path(status: "pending")
        find('#menu-due-later').click
 
        expect(page).to have_text "Pending Due Later"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Pending Past Due"
        expect(page).to_not have_text "Pending Not Due"
      end
    end
    context "and the user requests not_due tasks" do
      it "displays only the pending not_due tasks" do
        visit root_path(status: "pending")
        find('#menu-not-due').click
 
        expect(page).to have_text "Pending Not Due"
        expect(page).to_not have_text "Completed Not Due"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Pending Past Due"
      end
    end
  end
  context "when the user requests all tasks" do
    context "and the user requests past_due tasks" do
      it "displays only past_due tasks" do
        visit root_path
        find('#menu-past-due').click
 
        expect(page).to have_text "Pending Past Due"
        expect(page).to have_text "Completed Past Due"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Pending Not Due"
        expect(page).to_not have_text "Completed Not Due"
      end
    end
    context "and the user requests due_soon tasks" do
      it "displays only due_soon tasks" do
        visit root_path
        find('#menu-due-soon').click
 
        expect(page).to have_text "Pending Due Soon"
        expect(page).to have_text "Completed Due Soon"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Pending Past Due"
        expect(page).to_not have_text "Completed Past Due"
        expect(page).to_not have_text "Pending Not Due"
        expect(page).to_not have_text "Completed Not Due"
      end
    end
    context "and the user requests due_later tasks" do
      it "displays only due_later tasks" do
        visit root_path
        find('#menu-due-later').click
 
        expect(page).to have_text "Pending Due Later"
        expect(page).to have_text "Completed Due Later"
        expect(page).to_not have_text "Pending Past Due"
        expect(page).to_not have_text "Completed Past Due"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Pending Not Due"
        expect(page).to_not have_text "Completed Not Due"
      end
    end
    context "and the user requests not_due tasks" do
      it "displays only not_due tasks" do
        visit root_path
        find('#menu-not-due').click
 
        expect(page).to have_text "Pending Not Due"
        expect(page).to have_text "Completed Not Due"
        expect(page).to_not have_text "Pending Due Later"
        expect(page).to_not have_text "Completed Due Later"
        expect(page).to_not have_text "Pending Due Soon"
        expect(page).to_not have_text "Completed Due Soon"
        expect(page).to_not have_text "Pending Past Due"
        expect(page).to_not have_text "Completed Past Due"
      end
    end
  end
end
