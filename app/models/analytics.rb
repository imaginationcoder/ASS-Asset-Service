class Analytics
  include Mongoid::Document
  include Mongoid::Timestamps

  # Common fields
  field :ip_address # accessed from
  field :event # 'Time Spent', 'Permission visited etc..'
  field :app_version # current published version
  field :platform_category_id # embedded category

  belongs_to :platform # from which platform
  belongs_to :app, index: true
  belongs_to :template,index: true # tour step or permission

end
