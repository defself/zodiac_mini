FactoryGirl.define do
  factory :zodiac do
    sequence :sign do
      Zodiac.signs.keys[rand 12]
    end
    sequence :date do
      Zodiac.find_by(sign: Zodiac.signs[sign].to_s).date
    end
  end

end
