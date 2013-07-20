class CorporationKey < ActiveRecord::Base
  belongs_to :corporation, counter_cache: true

  validates_associated :corporation

  validates :v_code, :length => { :is => 64 }
  validates :id, :v_code, :uniqueness => true

  validates_with ApiValidator

  after_create do |key|
    info = EveApiHelper::EveApi.new(key.id, key.v_code).key_info
    key.corporation = Corporation.find(info.key.characters.first.corporationID)
    key.save
    UpdateCorporationMembersWorker.perform_async info.key.characters.first.corporationID
  end
end
