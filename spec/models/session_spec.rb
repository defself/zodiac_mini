require 'rails_helper'

describe Session do
  let(:zodiac) { Zodiac.all[rand 12] }
  let(:user) { create :user, zodiac: zodiac }
  let(:session) { build :session, user: user }

  it "should has validations" do
    should validate_presence_of :user_id
  end

  it "should has relationships" do
    should belong_to :user
  end

  it "should been saved successfully" do
    expect(session.save).to be_truthy
  end
end
