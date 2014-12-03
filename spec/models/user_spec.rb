require 'rails_helper'

describe User do
  let(:zodiac) { Zodiac.all[rand 12] }
  let(:user) { build :user, zodiac: zodiac }

  it "has validations" do
    should validate_presence_of     :email
    should validate_presence_of     :password
    should validate_presence_of     :birthday
    should validate_confirmation_of :password
  end

  it "has relationships" do
    should have_one  :session
    should belong_to :zodiac
    should have_many :horoscopes
  end

  it "is saved successfully" do
    expect(user.save).to be_truthy
  end
end
