class AddMembersCount < ActiveRecord::Migration
  def up
    add_column :corporations, :members_count, :integer, :default => 0
  end

  def down
    remove_column :corporations, :members_count
  end
end
