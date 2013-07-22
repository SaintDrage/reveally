class Location < ActiveRecord::Base
  has_many :member_trackings
end
