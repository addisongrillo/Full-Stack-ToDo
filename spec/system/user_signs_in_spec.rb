require "rails_helper"
 
RSpec.describe "user sign in", type: :system, js: true do
  it "redirects the user to the root page" do
    user = User.create(email: "some@guy.com", password: "password")

    visit new_user_session_path
    fill_in "user_email", with: "some@guy.com"
    fill_in "user_password", with: "password"
    click_button "Log in"
 
    expect(page.current_path).to eq(root_path)
    expect(page).to have_text("some@guy.com")
  end
end
