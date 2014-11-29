require 'rails_helper'

describe "User", type: :feature do
  let(:zodiac)    { create :zodiac }
  let(:user)      { create :user, zodiac: zodiac }
  let(:yesterday) { create :horoscope, zodiac: zodiac, forecast: "All was good" }
  let(:today)     { create :horoscope, zodiac: zodiac, forecast: "All is good" }
  let(:tomorrow)  { create :horoscope, zodiac: zodiac, forecast: "All will be good" }

  include_context 'logged in user'

  before do
    Horoscope.stub(:yesterday).and_return(yesterday)
    Horoscope.stub(:today).and_return(today)
    Horoscope.stub(:tomorrow).and_return(tomorrow)
  end

  it "sign in page" do
    visit user_path(user)

    expect(page).to have_content user.email
    expect(page).to have_content yesterday.forecast
    expect(page).to have_content today.forecast
    expect(page).to have_content tomorrow.forecast
    expect(page).to have_link("All users", href: users_path)

    click_link("All users")

    expect(page).to have_content "Users list"
  end

  it "all users" do
    test_user = create(:user, email: "test@zodiac.com")
    visit users_path

    expect(page).to have_content "Users list"
    expect(page).to have_link(user.email)
    expect(page).to have_link(test_user.email)

    click_link test_user.email

    expect(page).to have_content test_user.email
  end

end
