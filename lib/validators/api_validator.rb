include EveApiHelper

DIR_MASK = '67108863'
CHAR_MASK = '268435455'


class ApiValidator < ActiveModel::Validator
  def validate(record)
    if record.errors.messages.empty?
      info = EveApi.new(record.id, record.v_code).key_info
      record.errors :base,'API key is temporary! Please create a not expire key.' unless info.key.expires.empty?
      case info.key.type
        when 'Corporation'
          mask = DIR_MASK
        else
          mask = CHAR_MASK
      end
      record.errors.add :base, "Improper access mask! Please set the #{mask}" unless info.key.accessMask == mask
      corporation_ids = Array.new
      info.key.characters.each { |character| corporation_ids.push(character.corporationID) }
      puts 'corps ids:', corporation_ids
      record.errors.add :base, 'You are not a member of our alliance!' unless Corporation.where(id: corporation_ids).empty?
    end
  end
end