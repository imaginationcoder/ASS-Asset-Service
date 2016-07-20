class App
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Token
  include Mongoid::Paranoia

  ## Fields
  field :name
  token field_name: :client_id, length: 20, retry_count: 3, contains: :fixed_numeric, override_to_param: false
  token field_name: :secret_token, length: 40, retry_count: 3, contains: :alphanumeric, override_to_param: false
  field :description
  field :is_sandbox_mode , type: Boolean, default: true
  field :published_version , type: Integer, default: 0
  field :is_published, type: Boolean, default: false

  ## Validations
  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates :user, associated: true

  ## Indexes
   index({ current_version: 1 })
  ## Uploader
  mount_uploader :logo, AssetUploader, dependent: :destroy

  ## Associations
  belongs_to :user, index: true
  has_many :app_access_tokens , dependent: :destroy, autosave: true
  has_many :templates, dependent: :destroy, autosave: true
  belongs_to :platform,index: true
  embeds_many :versions, cascade_callbacks: true

  accepts_nested_attributes_for :templates, allow_destroy: true

  def tour_templates
    templates.where(permission: Permission.tour)
  end

  def logo_url
    logo.present? ? logo.thumb.url : 'http://placehold.it/100x100&text=Logo'
  end

  def find_template(permission)
    templates.where(permission: permission).first
  end



end
