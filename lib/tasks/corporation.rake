namespace :corporation do
  desc "Update corporation on the database"
  task update: :environment do
    UpdateCorporationsWorker.perform_async
  end

  desc "TODO"
  task update_members: :environment do
    Corporation.where('corporation_keys_count > 0').ids.each do |corporation_id|
      UpdateCorporationMembersWorker.perform_async corporation_id
    end
  end

end
