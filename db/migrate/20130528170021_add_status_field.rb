class AddStatusField < ActiveRecord::Migration
  def up
    add_column :corporations, :status, :boolean, default: 1, null: false
  end

  def down
    remove_column :corporations, :status
  end
end
