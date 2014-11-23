# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Zodiac.destroy_all if Zodiac.any?
DATES = [[20, 18], [19, 20], [21, 19], [20, 20], [21, 20], [21, 22],
         [23, 22], [23, 22], [23, 22], [23, 21], [22, 21], [22, 19]]

year = Date.current.year
Zodiac::signs.each do |sign, index|
  date          = DATES[index]
  current_month = index + 1
  next_month    = current_month + 1
  if next_month > 12
    next_month = 1
    next_year  = year.next
  end

  Zodiac.create(sign: sign,
                date: Date.new(year, current_month, date.first)..Date.new(next_year || year, next_month, date.last))
end
