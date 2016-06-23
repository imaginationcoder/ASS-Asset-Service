# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Preference.destroy_all

{'Tour'=> 'TR','Camera'=> 'CAM', 'Location'=> 'LN'}.each do |key,val|
  Preference.create(name: key, abbreviation: val)
end

Platform.destroy_all
['iOS', 'Android'].each do |name|
  Platform.create(name: name)
end
# Platform Categories
platform = Platform.where(name: 'iOS').first
platform.platform_categories.create(name: 'iPad')
platform.platform_categories.create(name: 'iPhone')



#User.destroy_all
User.where(email: 'testuser@test.com').first.destroy!
user = User.create(fname: 'test', lname: 'user', email: 'testuser@test.com',password: '12345678', password_confirmation: '12345678')


# Create Application
user.apps.each do |app|
  app.destroy!
end
#application = user.apps.create(name: 'test iOS',platform_ids: [ Platform.all.map(&:id) ], description: ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque id nunc nec volutpat.')

app = user.apps.new(platforms: [Platform.first],name: 'test iOS',
                    description: ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque id nunc nec volutpat.',
                    sw_version: '1.0.0')
# Create Tour
tour_preference = Preference.tour
['1','2','3'].each do |n|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background#{n}.jpg")) do |f|
    pre_prompt = app.pre_prompts.build(source: f, preference: tour_preference,
                                       header: 'HeaderContent..', footer: 'Footer Content', content: 'Some Content')
    ['1','2'].each do |m|
      File.open(Rails.root.join('app', 'assets', 'images', 'button_actions', "#{m}.png")) do |f|
        pre_prompt.button_actions.build(source: f, btn_text: m)
      end
    end
  end
end

app.save!

# Create other preferences(Cam, Location etc)

Preference.nin(name: 'Tour').each do |preference|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background1.jpg")) do |f|
    pre_prompt = app.pre_prompts.build(source: f, preference: preference,
                                       header: 'HeaderContent..', footer: 'Footer Content', content: 'Some Content')
    ['1','2'].each do |m|
      File.open(Rails.root.join('app', 'assets', 'images', 'button_actions', "#{m}.png")) do |f|
        pre_prompt.button_actions.build(source: f, btn_text: m)
      end
    end
  end
end

app.save!










