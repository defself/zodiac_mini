class CreateZodiacs < ActiveRecord::Migration
  def change
    create_table :zodiacs do |t|
      t.integer :sign, null: false
      t.daterange :date, null: false
    end
  end
end
