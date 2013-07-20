class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.integer :corporation_id
      t.datetime :join_at
      t.integer :base_id
      t.string :base
      t.string :title

      t.timestamps
    end
  end
end
