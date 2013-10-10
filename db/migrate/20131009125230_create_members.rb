class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :studentid
      t.string :name
      t.string :email
      t.boolean :paid

      t.timestamps
    end
  end
end
