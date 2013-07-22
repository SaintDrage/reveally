class MemberTracking < ActiveRecord::Base
  belongs_to :member
  belongs_to :location

  validates_uniqueness_of :member_id, :scope => :logon
end
