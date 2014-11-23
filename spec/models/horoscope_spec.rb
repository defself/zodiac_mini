require 'rails_helper'

describe Horoscope do
  let(:horoscope) { build :horoscope }

  it "should has validations" do
    should validate_presence_of :forecast
    should validate_presence_of :date
  end

  it "should has relationships" do
    should belong_to :user
  end

  it "should been saved successfully" do
    expect(horoscope.save).to eq true
  end
end
