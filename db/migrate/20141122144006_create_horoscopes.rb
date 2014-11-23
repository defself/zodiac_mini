class CreateHoroscopes < ActiveRecord::Migration
  def change
    create_table :horoscopes do |t|
      t.text :forecast, null: false
      t.date :date, null: false
      t.belongs_to :zodiac, index: true, null: false

      t.timestamps
    end
  end
end
