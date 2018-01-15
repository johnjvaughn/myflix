require "spec_helper"

feature "User signs in" do
  scenario "with valid login" do
    user = Fabricate(:user)
    sign_in(user)
    expect(page).to have_content(user.full_name)
  end
end
