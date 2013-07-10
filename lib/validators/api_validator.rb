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
            mask = Figaro.env.dir_mask
          else
            mask = Figaro.env.char_mask
            record.errors.add :base, 'Wrong type of API Key! Need a corporate key' if record.is_a? CorporationKey
        end
        record.errors.add :base, "Improper access mask! Please set the #{mask}" unless info.key.accessMask == mask
        corporation_ids = Array.new
        info.key.characters.each { |character| corporation_ids.push(character.corporationID) }
        record.errors.add :base, 'You are not a member of our alliance!' if Corporation.where(id: corporation_ids).empty?
      rescue EveApiHelper::ApiBadError
        record.errors.add :base, 'Your key is not valid! Please enter another key'
      rescue EveApiHelper::ApiOkError
        record.errors.add :base, 'Problems connecting to EveApi server. Please try later'
      end
    end
  end
end