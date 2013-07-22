class CreateMemberTrackings < ActiveRecord::Migration
  def change
    create_table :member_trackings do |t|
      t.integer :member_id
      t.datetime :logon
      t.datetime :logoff
      t.integer :location_id

      t.timestamps
    end
  end
end
