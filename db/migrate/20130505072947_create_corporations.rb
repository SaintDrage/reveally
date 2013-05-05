class CreateCorporations < ActiveRecord::Migration
  def change
    create_table :corporations do |t|
      t.string :name
      t.string :ticker
      t.text :description
      t.string :url
      t.datetime :join_at

      t.timestamps
    end
  end
end
