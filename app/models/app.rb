class App
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Token
  include Mongoid::Paranoia

  ## Fields
  field :name
  field :expires_at , type: Time, default: 1.year.from_now
  token field_name: :client_id, length: 20, retry_count: 3, contains: :fixed_numeric, override_to_param: false
  token field_name: :secret_token, length: 40, retry_count: 3, contains: :alphanumeric, override_to_param: false
  field :platform_ids ,type: Array ,default: [] # same uniq client and secret for all platforms
  field :description

  ## Validations
  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates :user, associated: true

  ## Indexes
  index({ "platforms.name" => 1}, { unique: true})

  ## Associations
  belongs_to :user, index: true
  has_one :tour, dependent: :destroy
  has_many :app_access_tokens , dependent: :destroy

  ## Callbacks
  # uniq platform_id only
  before_save do |record|
    record.platform_ids = record.platform_ids.uniq
  end


  def expired?
    self.expires_at < Time.now
  end

end
