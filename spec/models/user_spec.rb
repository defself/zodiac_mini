require 'rails_helper'

describe User do
  let(:user) { build :user }

  it "should has validations" do
    should validate_presence_of     :email
    should validate_presence_of     :password
    should validate_presence_of     :birthday
    should validate_confirmation_of :password
  end

  it "should has relationships" do
    should have_many :horoscopes
    should have_one :session
  end

  it "should been saved successfully" do
    expect(user.save).to eq true
  end
end
