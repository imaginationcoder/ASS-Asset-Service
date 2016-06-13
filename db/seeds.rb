# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Platform.destroy_all
['iOS', 'Android'].each do |name|
  Platform.create(name: name)
end


User.destroy_all
user = User.create(fname: 'test', lname: 'user', email: 'testuser@test.com',password: '12345678', password_confirmation: '12345678')


# Create Application
Application.destroy_all
user.applications.create(name: 'test iOS',platform_ids: [ Platform.all.map(&:id) ])

