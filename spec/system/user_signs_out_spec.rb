require "rails_helper"
 
RSpec.describe "user sign out", type: :system, js: true do
  it "lets users sign out" do
    user = User.create(email: "some@guy.com", password: "password")
    sign_in(user)
 
    visit root_path
    click_link "some@guy.com"
    click_link "Sign Out"
 
    expect(page.current_path).to eq(new_user_session_path)
    expect(page).to have_text("Log in")
  end
end
