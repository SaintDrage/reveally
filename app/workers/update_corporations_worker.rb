class UpdateCorporationsWorker
  include Sidekiq::Worker
  include EveApiHelper

  def perform
    begin
      corporations_on_site = Corporation.all
      current_corporations = Array.new
      api = EveApi.new
      api.alliance_list.alliances.each do |alliance|
        if alliance.allianceID == Figaro.env.ally_id
          alliance.memberCorporations.each do |corporation|
            current_corporations.append(corporation.corporationID)
            info = api.corporation_info(corporation.corporationID)
            if corporations_on_site.ids.include? corporation.corporationID.to_i
              corporations_on_site.find(corporation.corporationID).update(
                  {
                      description: info.description,
                      url: info.url
                  }
              )
            else
              Corporation.create(
                  {
                      id: corporation.corporationID.to_i,
                      name: info.corporationName,
                      ticker: info.ticker,
                      description: info.description,
                      url: info.url,
                      join_at: corporation.startDate
                  }
              )
            end
          end
        end
      end
      #invalid_corporations = Corporation.all.ids - current_corporations
    rescue EveApiHelper::ApiBadError
      NIL
    end
  end
end