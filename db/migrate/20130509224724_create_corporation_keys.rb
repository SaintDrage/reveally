class CreateCorporationKeys < ActiveRecord::Migration
  def change
    create_table :corporation_keys do |t|
      t.string :v_code
      t.integer :corporation_id
    end
  end
end
