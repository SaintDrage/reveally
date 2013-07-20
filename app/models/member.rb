class Member < ActiveRecord::Base
  belongs_to :corporation, counter_cache: true

  validates_associated :corporation
end
