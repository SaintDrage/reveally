class Member < ActiveRecord::Base
  belongs_to :corporation, counter_cache: true
  has_many :member_trackings

  validates_associated :corporation
end
