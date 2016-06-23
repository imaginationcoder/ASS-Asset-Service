class PlatformCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  field :name # iPad, iPhone for iOS

  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  ## Associations
  embedded_in :platform
end
