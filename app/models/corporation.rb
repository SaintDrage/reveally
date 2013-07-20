class Corporation < ActiveRecord::Base
  has_many :corporation_keys
  has_many :members
end
