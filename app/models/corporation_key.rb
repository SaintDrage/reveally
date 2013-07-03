class CorporationKey < ActiveRecord::Base
  belongs_to :corporation

  validates_associated :corporation

  validates :v_code, :length => { :is => 64 }

  validates_with ApiValidator
end
