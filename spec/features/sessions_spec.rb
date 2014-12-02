require 'rails_helper'

describe "Session", js: true do
  let(:zodiac) { Zodiac.all[rand 12] }
  let(:user)   { create :user, zodiac: zodiac }

  it "sign in page" do
    visit new_session_path

    expect(page).to have_content "Sign in"
    expect(page).to have_selector('form')

    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password

    click_button "Login"
    expect(page).to have_content user.email
  end

end
