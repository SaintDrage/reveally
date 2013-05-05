# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# @TODO: load corporations from EVE API.
corporations = [
  {
    id: 10,
    name: 'The Tuskers',
    ticker: 'TT',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    url: 'http://example1.com',
    created_at: '2010-05-05 09:03:14',
    join_at: '2012-04-12 02:00:00',
  },
  {
    id: 20,
    name: 'Civic Court',
    ticker: 'CC',
    description: 'Integer metus dolor, dictum non dapibus sit amet, blandit eget ante.',
    url: 'http://example2.com',
    created_at: '2011-01-08 00:00:00',
    join_at: '2011-04-12 02:00:00',
  },
  {
    id: 30,
    name: 'Inherent Implants',
    ticker: 'II',
    description: 'Fusce augue leo, condimentum vitae consectetur eget, rutrum in turpis.',
    url: 'http://example3.com',
    created_at: '2008-01-05 09:03:14',
    join_at: '2012-04-12 02:00:00',
  }
]

puts "✩✩✩✩ Create corporations ✩✩✩✩"
corporations.each do |corporation|
   corporation = Corporation.create corporation
   puts " -> Corporation '#{corporation.name}' has been created!"
end
