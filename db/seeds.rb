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


#User.destroy_all
User.where(email: 'testuser@test.com').destroy_all
user = User.create(fname: 'test', lname: 'user', email: 'testuser@test.com',password: '12345678', password_confirmation: '12345678')


# Create Application
App.destroy_all
application = user.apps.create(name: 'test iOS',platform_ids: [ Platform.all.map(&:id) ], description: ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque id nunc nec volutpat.')

Tour.destroy_all
# Tour Setup
tour = application.create_tour(name: 'Test Tour')

# Assets
['1','2','3'].each do |n|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background#{n}.jpg")) do |f|
    tour.assets.create(source: f, heading: 'Header text', sub_text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu velit bibendum, hendrerit arcu nec, dictum est. Praesent lobortis tincidunt.')
  end
end


