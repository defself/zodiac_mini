class CreateZodiacs < ActiveRecord::Migration
  def change
    create_table :zodiacs do |t|
      t.string :sign, null: false
      t.daterange :date, null: false
    end
  end
end
