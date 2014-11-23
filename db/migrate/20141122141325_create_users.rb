class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.date :birthday, null: false
      t.belongs_to :zodiac, null: false

      t.timestamps
    end
  end
end
