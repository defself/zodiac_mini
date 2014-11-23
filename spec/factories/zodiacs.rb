FactoryGirl.define do
  factory :zodiac do
    sign "leo"
    date Date.today..Float::INFINITY
  end

end
