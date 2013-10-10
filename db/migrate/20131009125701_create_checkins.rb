class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :studentid
      t.date :date

      t.timestamps
    end
  end
end
