class PlatformCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  # names for iOS platform
  IOS_NAMES = ['All', 'iPhone 6s', 'iPhone 6 Plus', 'iPhone 6', 'iPhone 5', 'iPhone 5s', 'iPhone-family',
           'iPhone 4', 'iPhone 4s', 'iPad Mini', 'iPad Air', 'iPad Pro', 'iPad-family'] # names for iOS platform

  ANDROID_NAMES = ['All', 'Android 4.0','Android 4.1','Android 4.2','Android 4.3','Android 4.4',
                   'Android 5.0','Android 5.1','Android 6.0','Android 7.0']
  ## Fields
  field :name ,default: 'iPhone 6'


  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  ## Associations
  embedded_in :platform
end
