require "rails_helper"
 
RSpec.describe "editing account", type: :system, js: true do
  it "lets users change their email and password" do
    user = User.create(email: "some@guy.com", password: "password")
    sign_in(user)
 
    visit edit_user_registration_path
    fill_in "user_email", with: "other@guy.com"
    fill_in "user_password", with: "password2"
    fill_in "user_password_confirmation", with: "password2"
    fill_in "user_current_password", with: "password"
    click_button "Update"
 
    expect(page).to have_text("Your account has been updated successfully.")
  end
end
