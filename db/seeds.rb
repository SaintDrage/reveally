# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "✩✩✩✩ Create Corporations ✩✩✩✩"
include EveApiHelper
api = EveApi.new
api.alliance_list.alliances.each do |alliance|
  if alliance.allianceID == Figaro.env.ally_id
     alliance.memberCorporations.each do |corporation|
       info = api.corporation_info(corporation.corporationID)
       Corporation.create({
           id: corporation.corporationID,
           name: info.corporationName,
           ticker: info.ticker,
           description: info.description,
           url: info.url,
           join_at: corporation.startDate,
        })
       puts " -> Corporation '#{info.corporationName}' has been created!"
     end
  end
end

puts "✩✩✩✩ Create Corporation Keys ✩✩✩✩"

key = {
  id: 1234567,
  v_code: 'goin34342oi4n3f23o4nrou3242dj4nr2i34br4bt3i2rpb34jrn324kjfn2432g'
}
key = CorporationKey.create(key)

# Add key to first corporation.
corporation = Corporation.first

corporation.corporation_keys = [key]
corporation.save
