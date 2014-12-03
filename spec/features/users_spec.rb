require 'rails_helper'

describe "User", js: true do
  let(:zodiac)     { Zodiac.all[rand 12]  }
  let(:user)       { create :user, zodiac: zodiac }
  let(:user_attrs) { attributes_for :user, zodiac: zodiac }
  let(:yesterday)  { create :horoscope, zodiac: zodiac, forecast: "All was good" }
  let(:today)      { create :horoscope, zodiac: zodiac, forecast: "All is good" }
  let(:tomorrow)   { create :horoscope, zodiac: zodiac, forecast: "All will be good" }

  include_context 'logged in user'

  before do
    Horoscope.stub(:yesterday).and_return(yesterday)
    Horoscope.stub(:today).and_return(today)
    Horoscope.stub(:tomorrow).and_return(tomorrow)
  end

  it "registration" do
    visit new_user_path

    fill_in "Email",    with: user_attrs[:email]
    fill_in "Birthday", with: user_attrs[:birthday]
    fill_in "Password", with: user_attrs[:password]
    fill_in "Password Confirmation", with: user_attrs[:password]

    click_button "Register"
    expect(page).to have_content user_attrs[:email]
  end

  it "home page" do
    visit user_path(user)

    expect(page).to have_content user.email

    click_button "Yesterday"
    expect(page).to have_content yesterday.forecast
    expect(page).to have_content today.forecast

    click_button "Tomorrow"
    expect(page).to have_content tomorrow.forecast
    expect(page).to have_link("All users", href: users_path)

    click_link("All users", href: users_path)

    expect(page).to have_content "Users list"
  end

  it "all users" do
    test_user = create(:user, email: "test@zodiac.com", zodiac: zodiac)
    visit users_path

    expect(page).to have_content "Users list"
    #expect(page).to have_link(user.email)
    expect(page).to have_link(test_user.email)

    click_link test_user.email

    expect(page).to have_content test_user.email
  end

end
