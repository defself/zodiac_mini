require 'rails_helper'

describe Horoscope do
  let(:zodiac) { Zodiac.all[rand 12] }
  let(:horoscope) { build :horoscope, zodiac: zodiac }

  it "should has validations" do
    should validate_presence_of :forecast
    should validate_presence_of :date
    should validate_presence_of :zodiac_id
  end

  it "should has relationships" do
    should belong_to :zodiac
  end

  it "should been saved successfully" do
    expect(horoscope.save).to be_truthy
  end
end
