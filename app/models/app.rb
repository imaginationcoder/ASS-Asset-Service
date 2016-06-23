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
  #field :platform_ids ,type: Array ,default: [] # same uniq client and secret for all platforms
  field :description
  field :sw_version, default: '1.0' # software version('1.0', '1.0.1', '2.0')

  ## Validations
  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates :user, associated: true

  ## Indexes
  #index({ "platforms.name" => 1}, { unique: true})

  ## Associations
  belongs_to :user, index: true
  has_many :app_access_tokens , dependent: :destroy, autosave: true
  has_many :pre_prompts, dependent: :destroy, autosave: true
  has_and_belongs_to_many :platforms

  ## Callbacks
  # uniq platform_id only
=begin
  before_save do |record|
    record.platform_ids = record.platform_ids.uniq
  end
=end


  def expired?
    self.expires_at < Time.now
  end


  def tour_pre_prompts
    pre_prompts.where(preference: Preference.tour)
  end

end
