class PlatformCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  field :name # iPad, iPhone for iOS
  # names for iOS platform
  NAMES = ['iPhone 6s', 'iPhone 6 Plus', 'iPhone 6', 'iPhone 5', 'iPhone 5s', 'iPhone-family',
           'iPhone 4', 'iPhone 4s', 'iPad Mini', 'iPad Air', 'iPad Pro', 'iPad-family'] # names for iOS platform


  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  ## Associations
  embedded_in :platform
end
