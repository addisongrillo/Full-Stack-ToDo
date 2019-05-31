require "rails_helper"
 
RSpec.describe "viewing calendar", type: :system, js: true do
  let(:user){ User.create(email: "some@guy.com", password: "password") }
  let!(:last_month){ user.tasks.create(description: "Last Month", due_date: 1.month.ago.to_date) }
  let!(:this_month){ user.tasks.create(description: "This Month", due_date: Date.today) }
  let!(:next_month){ user.tasks.create(description: "Next Month", due_date: 1.month.from_now.to_date) }
  before do
    sign_in(user)
    visit calendar_path
  end
  context "when the user requests this month's tasks" do
    it "only shows this month's tasks" do
      expect(page).to have_text Date::MONTHNAMES[Date.today.month]
      expect(page).to have_text this_month.description

      if page.has_text? last_month.description
        expect(page.find("#day-#{last_month.due_date}")[:class]).to include("disabled")
      end
      if page.has_text? next_month.description
        expect(page.find("#day-#{next_month.due_date}")[:class]).to include("disabled")
      end
    end
  end
  context "when the user requests last month's tasks" do
    it "only shows last month's tasks" do
      find('#prev-month').click
 
      expect(page).to have_text Date::MONTHNAMES[1.month.ago.month]
      expect(page).to have_text last_month.description

      if page.has_text? this_month.description
        expect(page.find("#day-#{this_month.due_date}")[:class]).to include("disabled")
      end
      if page.has_text? next_month.description
        expect(page.find("#day-#{next_month.due_date}")[:class]).to include("disabled")
      end
    end
  end
  context "when the user requests next month's tasks" do
    it "only shows next month's tasks" do
      find('#next-month').click
 
      expect(page).to have_text Date::MONTHNAMES[1.month.from_now.month]
      expect(page).to have_text next_month.description

      if page.has_text? last_month.description
        expect(page.find("#day-#{last_month.due_date}")[:class]).to include("disabled")
      end
      if page.has_text? this_month.description
        expect(page.find("#day-#{this_month.due_date}")[:class]).to include("disabled")
      end
    end
  end
end
