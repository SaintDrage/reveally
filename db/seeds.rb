# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ALLY_ID = '99002003'

puts "✩✩✩✩ Create corporations ✩✩✩✩"
include EveApiHelper
list = alliance_list
list.alliances.each do |alliance|
  if alliance.allianceID == ALLY_ID
     alliance.memberCorporations.each do |corporation|
       info = corporation_info(corporation.corporationID)
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
