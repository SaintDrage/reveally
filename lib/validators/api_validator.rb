include EveApiHelper

DIR_MASK = '67108863'
CHAR_MASK = '268435455'


class ApiValidator < ActiveModel::Validator
  def validate(record)
    if record.errors.messages.empty?
      begin
        info = EveApi.new(record.id, record.v_code).key_info
        record.errors :base,'API key is temporary! Please create a not expire key.' unless info.key.expires.empty?
        case info.key.type
          when 'Corporation'
            mask = DIR_MASK
          else
            mask = CHAR_MASK
            record.errors.add :base, 'Wrong type of API Key! Need a corporate key' if record.is_a? CorporationKey
        end
        record.errors.add :base, "Improper access mask! Please set the #{mask}" unless info.key.accessMask == mask
        corporation_ids = Array.new
        info.key.characters.each { |character| corporation_ids.push(character.corporationID) }
        record.errors.add :base, 'You are not a member of our alliance!' if Corporation.where(id: corporation_ids).empty?
      rescue EveApiHelper::ApiBadError
        record.errors.add :base, 'Hmm.. Something wrong!'
      end
    end
  end
end