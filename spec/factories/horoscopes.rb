FactoryGirl.define do
  factory :horoscope do
    forecast "Today is a wonderful day!"
    date Date.current
    zodiac nil
  end

end
