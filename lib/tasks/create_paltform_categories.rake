namespace :db  do
  desc "adding platform categories to platform"
  task :add_platform_categories => :environment do
    Platform.all.each do |platform|
      if platform.is_ios?
        PlatformCategory::IOS_NAMES.each do |name|
          platform.platform_categories.find_or_create_by(name: name)
        end
      else
        PlatformCategory::ANDROID_NAMES.each do |name|
          platform.platform_categories.find_or_create_by(name: name)
        end
      end
    end
  end
end