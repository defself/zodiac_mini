require 'rails_helper'

describe Zodiac do
  let(:zodiac) { build :zodiac }

  it "has validations" do
    should validate_presence_of :sign
    should validate_presence_of :date
  end

  it "has relationships" do
    should have_many :users
    should have_many :horoscopes
  end

  it "is saved successfully" do
    expect(zodiac.save).to be_truthy
  end
end
