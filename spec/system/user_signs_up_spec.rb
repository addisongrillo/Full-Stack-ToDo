require "rails_helper"
 
RSpec.describe "user sign up", type: :system, js: true do
  it "redirects the user to the root page" do
    visit new_user_registration_path
    fill_in "user_email", with: "some@guy.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page.current_path).to eq(root_path)
    expect(page).to have_text("some@guy.com")
  end
end
