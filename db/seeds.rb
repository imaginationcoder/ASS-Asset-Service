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
Analytics.collection.drop



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
platform_category = platform.platform_categories.first


user = User.new(full_name: 'test user', email: 'testuser@test.com',password: '12345678', password_confirmation: '12345678', company: 'Maisa')
user.skip_confirmation!
user.save!
app = user.apps.new(platform: platform, name: 'test iOS',description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque id nunc nec volutpat.')


## Add Logo
File.open(Rails.root.join('app', 'assets', 'images', "small-logo-blue.png")) do |f|
  app.logo = f
end



# Create Tour
tour_permission = Permission.tour
# Tour step assets ---
['1','2','3'].each do |n|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background#{n}.jpg")) do |f|
    template = app.templates.build(source: f, is_tour: true,permission: tour_permission, platform_category_id: platform_category.id)
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
Permission.where(:id.ne => tour_permission.id).each do |permission|
  File.open(Rails.root.join('app', 'assets', 'images', 'home', "background#{[1,2,3].sample}.jpg")) do |f|
    template = app.templates.build(source: f, is_tour: false,permission: permission, platform_category_id: platform_category.id)
    template.text_assets_attributes = [{text: 'I am top', position: TextAsset::POSITIONS[0]},
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

## update versions
v1 = app.versions.where(number: 1).first
v1.update(published: true)
v2 = app.versions.where(number: 2).first
v2.update(published: true)

## Timed Analytics for all templates
app.versions.each do |version|
  app.templates.where(app_version: version.number).each do |template|
    [4,5,6,7,8,9].sample.times do
      TimedAnalytics.create!(app: app, template: template, app_version: version.number, platform: platform,
                             platform_category_id: platform_category.id, event: 'Time Spent',
                             ip_address: Faker::Internet.ip_v4_address, time_spent: Faker::Number.between(5, 100))
    end
  end
end
















