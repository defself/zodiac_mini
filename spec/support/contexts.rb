shared_context "logged in user" do
  let(:zodiac) { Zodiac.all[rand 12] }
  let(:user)   { create :user, zodiac: zodiac }

  before do
    visit new_session_path

    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"
  end
end
