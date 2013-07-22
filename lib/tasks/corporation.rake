namespace :corporation do
  desc "Update corporation on the database"
  task update: :environment do
    UpdateCorporationsWorker.perform_async
  end

  desc "TODO"
  task update_members: :environment do
    k = 0
    Corporation.where('corporation_keys_count > 0').ids.each do |corporation_id|
      UpdateCorporationMembersWorker.perform_at(Time.now + k, corporation_id)
      k += 5
    end
  end

end
