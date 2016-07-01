# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Delete collections
Permission.collection.drop
Platform.collection.drop
User.collection.drop
App.collection.drop
PrePrompt.collection.drop



{'Tour'=> 'TR','Camera'=> 'CAM', 'Contacts'=> 'CT', 'Notifications'=> 'NF', 'Location'=> 'LN' }.each do |key,val|
  Permission.create(name: key, abbreviation: val)
end


['iOS', 'Android'].each do |name|
  Platform.create(name: name)
end
# Platform Categories
platform = Platform.where(name: 'iOS').first
platform.platform_categories.create(name: 'iPhone')
platform.platform_categories.create(name: 'iPad')


user = User.create(fname: 'test', lname: 'user', email: 'testuser@test.com',password: '12345678', password_confirmation: '12345678', company: 'Maisa')
app = user.apps.new(platform: platform, platform_category_id: platform.platform_categories.first.id ,name: 'test iOS',
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque id nunc nec volutpat.',
                    sw_version: '1.0')
# Create Tour
tour_permission = Permission.tour
['1','2','3'].each do |n|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background#{n}.jpg")) do |f|
    pre_prompt = app.pre_prompts.build(source: f, permission: tour_permission,
                                       header: 'HeaderContent..', header_position: 'center',
                                       footer: 'FooterContent..', footer_position: 'center',
                                       content: 'Lorem ipsum dolor sit amet', content_position: 'center')
    pre_prompt.button_actions.build(btn_type: 0) # none
    pre_prompt.button_actions.build(btn_type: 1, text: 'btn text', text_position: 'center') # Text
    ['1','2'].each do |m| # Image
      File.open(Rails.root.join('app', 'assets', 'images', 'button_actions', "#{m}.png")) do |f|
        pre_prompt.button_actions.build(source: f, btn_type: 2)
      end
    end
  end
end

app.save!

# Create other permission(Cam, Location etc)
=begin

Permission.nin(name: 'Tour').each do |permission|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background1.jpg")) do |f|
    pre_prompt = app.pre_prompts.build(source: f, permission: permission,
                                       header: 'HeaderContent..', footer: 'Footer Content', content: 'Some Content')
    ['1','2'].each do |m|
      File.open(Rails.root.join('app', 'assets', 'images', 'button_actions', "#{m}.png")) do |f|
        pre_prompt.button_actions.build(source: f, btn_text: m)
      end
    end
  end
end

app.save!
=end










