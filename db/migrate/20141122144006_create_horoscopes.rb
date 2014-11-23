class CreateHoroscopes < ActiveRecord::Migration
  def change
    create_table :horoscopes do |t|
      t.text :forecast
      t.date :date
      t.references :user, index: true

      t.timestamps
    end
  end
end
