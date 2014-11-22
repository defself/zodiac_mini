require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it "should have validation" do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
    should validate_presence_of(:birthday)
    should validate_confirmation_of(:password)
  end

  it "should being saved" do
    expect(user.save).to eq(true)
  end
end
