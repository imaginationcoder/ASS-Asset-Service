class Application
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Token

  ## Fields
  field :name
  field :expires_at , type: Time, default: 1.year.from_now
  token field_name: :client_id, length: 16, retry_count: 3, contains: :fixed_numeric
  token field_name: :secret_token, length: 32, retry_count: 3, contains: :alphanumeric
  field :platform_ids ,type: Array ,default: [] # same uniq client and secret for all platfroms

  ## Associations
  belongs_to :user, index: true

  ## Validations
  validates :name, presence: true, uniqueness: true
  validates :user, associated: true

  ## Indexes
  index({ "platforms.name" => 1}, { unique: true})


  ## Callbacks
  # uniq platform_id only
  before_save do |record|
    record.platform_ids = record.platform_ids.uniq
  end


end
