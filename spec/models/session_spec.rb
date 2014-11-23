require 'rails_helper'

describe Session do
  let(:user) { create :user }
  let(:session) { build :session, user: user }

  it "should has relationships" do
    should belong_to :user
  end

  it "should been saved successfully" do
    expect(session.save).to eq true
  end
end
