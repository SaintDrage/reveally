class UpdateCorporationMembersWorker
  include Sidekiq::Worker
  include EveApiHelper

  def perform(corporation_id)
    corporation = Corporation.find(corporation_id)
    actual_members = Array.new
    corporation.corporation_keys.each do |api_key|
      if api_key.valid?
        EveApi.new(api_key.id, api_key.v_code).corporation_member_tracking(true).members.each do |member|
          actual_members.append member.characterID.to_i
          if Member.exists? member.characterID
            db_member = Member.find(member.characterID)
            db_member.update(
                :corporation_id => corporation_id,
                :base_id => member.baseID,
                :base => member.base,
                :title => member.title
            )
          else
            db_member = corporation.members.create(
                :id => member.characterID.to_i,
                :name => member.name,
                :join_at => member.startDateTime.to_datetime,
                :base_id => member.baseID,
                :base => member.base,
                :title => member.title
            )
          end
          if member.logonDateTime.to_datetime < member.logoffDateTime.to_datetime
            logoff = member.logoffDateTime.to_datetime
          else
            logoff = Time.now
          end
          db_member.member_trackings.where(
              :logon => member.logonDateTime.to_datetime,
              :location_id => Location.where(:id => member.locationID, :name => member.location).first_or_create.id
          ).first_or_create.update(
              :logoff => logoff
          )
        end
        break
      end
    end
    invalid_members = corporation.members.ids - actual_members
    Member.where(:id => invalid_members).update_all(:corporation_id => nil)
    Corporation.reset_counters(corporation_id, :members)
  end
end