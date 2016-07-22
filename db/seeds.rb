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
Template.collection.drop



{'Tour'=> 'TR','Camera'=> 'CAM', 'Contacts'=> 'CT', 'Location'=> 'LN', 'Notifications'=> 'NF' }.each do |key,val|
  description = "#{key} permission allows you to set-up a dynamic pre-prompt before the standard system
            #{key.downcase} permission dialog. ASSSDK supports pre-prompts containing text, images, etc."
  pro_tip = "Informing users why you need #{key.upcase.singularize} PERMISSION in-advance increase chances of
            user giving you the required permission."
  Permission.create(name: key, abbreviation: val, description: description, pro_tip: pro_tip)
end


['iOS', 'Android'].each do |name|
  Platform.create(name: name)
end
# Platform Categories
platform = Platform.where(name: 'iOS').first
PlatformCategory::NAMES.each do |name|
  platform.platform_categories.create(name: name)
end


user = User.create(fname: 'test', lname: 'user', email: 'testuser@test.com',password: '12345678', password_confirmation: '12345678', company: 'Maisa')
app = user.apps.new(platform: platform, name: 'test iOS',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque id nunc nec volutpat.')
## Add Logo
File.open(Rails.root.join('app', 'assets', 'images', "small-logo-blue.png")) do |f|
  app.logo = f
end



# Create Tour
tour_permission = Permission.tour




['1','2','3'].each do |n|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background#{n}.jpg")) do |f|
    template = app.templates.build(source: f, permission: tour_permission, platform_category_id: platform.platform_categories.first.id)
    template.text_assets_attributes = [{text: 'Welcome to my app', position: TextAsset::POSITIONS[0]},
                                                           {text: 'I am center', position: TextAsset::POSITIONS[1]},
                                                           {text: 'I am bottom', position: TextAsset::POSITIONS.last}]

     # total 5 button actions
    template.button_actions_attributes = [{ btn_type: 1, label: 'Next'},
                                         { btn_type: 1, label: 'Go', target_event: 'SOME TARGET'},
                                         { btn_type: 1, label: 'Skip', target_event: 'SKIP EVENT'} ]

    btn_action =  template.button_actions.build(btn_type: 2)
    File.open(Rails.root.join('app', 'assets', 'images', 'button_actions', "1.png")) do |f|
      btn_action.source = f
    end

    btn_action =  template.button_actions.build(btn_type: 2, target_event: 'SOME BUTTON ACTION EVENT')
    File.open(Rails.root.join('app', 'assets', 'images', 'button_actions', "2.png")) do |f|
      btn_action.source = f
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










