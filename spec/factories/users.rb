FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "#{zodiac.sign}_#{n}@zodiac.com"
    end
    password "123456789"
    birthday 24.years.ago
    zodiac nil
  end

end
