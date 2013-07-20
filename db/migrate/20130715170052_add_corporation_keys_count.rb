class AddCorporationKeysCount < ActiveRecord::Migration
  def up
    add_column :corporations, :corporation_keys_count, :integer, :default => 0
  end

  def down
    remove_column :corporations, :corporation_keys_count
  end
end
