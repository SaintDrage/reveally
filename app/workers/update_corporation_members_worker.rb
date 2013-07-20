class UpdateCorporationMembersWorker
  include Sidekiq::Worker
  include EveApiHelper

  def perform(corporation_id)
    corporation = Corporation.find(corporation_id)
    actual_members = Array.new
    corporation.corporation_keys.each do |api_key|
      if api_key.valid?
        EveApi.new(api_key.id, api_key.v_code).corporation_member_tracking.members.each do |member|
          actual_members.append member.characterID.to_i
          if Member.exists? member.characterID
            Member.find(member.characterID).update(
                {
                    corporation_id: corporation_id,
                    base_id: member.baseID,
                    base: member.base,
                    title: member.title
                }
            )
          else
            corporation.members.create(
                {
                    id: member.characterID.to_i,
                    name: member.name,
                    join_at: DateTime.strptime(member.startDateTime, '%Y-%m-%d %H:%M:%S'),
                    base_id: member.baseID,
                    base: member.base,
                    title: member.title
                }
            )
          end
        end
        break
      end
    end
    invalid_members = corporation.members.ids - actual_members
    Member.where(:id => invalid_members).update_all(:corporation_id => nil)
    Corporation.reset_counters(corporation_id, :members)
  end
end