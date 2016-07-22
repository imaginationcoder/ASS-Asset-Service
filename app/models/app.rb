class App
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Token
  include Mongoid::Paranoia

  ## Fields ----------------------------------------- ##
  field :name
  token field_name: :client_id, length: 20, retry_count: 3, contains: :fixed_numeric, override_to_param: false
  token field_name: :secret_token, length: 40, retry_count: 3, contains: :alphanumeric, override_to_param: false
  field :description
  field :is_sandbox_mode , type: Boolean, default: true

  ## Validations ------------------------------------- ##
  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates :user, associated: true

  ## Uploader ----------------------------------------- ##
  mount_uploader :logo, AssetUploader, dependent: :destroy

  ## Associations ------------------------------------- ##
  belongs_to :user, index: true
  has_many :app_access_tokens , dependent: :destroy, autosave: true
  has_many :templates, dependent: :destroy, autosave: true#,after_add: :some_action, after_remove: :some_action
  belongs_to :platform,index: true
  embeds_many :versions, cascade_callbacks: true

  accepts_nested_attributes_for :templates, allow_destroy: true

  ## Indexes ----------------------------------------- ##
  index "versions.editing" => 1
  index "versions.publishing" => 1


  ## Callbacks ----------------------------------------- ##
  # build default version with unpublished state (user will publish the version from dashboard later)
  after_create :create_default_version

  # after_save do |document|
  #   # Handle callback here.
  # end


  ## Instance methods
  # currently editing version tour assets
  def tour_templates
    templates.where(app_version: editing_version.number, permission: Permission.tour)
  end

  def logo_url
    logo.present? ? logo.thumb.url : 'http://placehold.it/100x100&text=Logo'
  end

  # currently editing version permission assets
  def find_template(permission)
    templates.where(app_version: editing_version.number).where(permission: permission).first
  end

  ### Version Management related stuff *************************** ----##
  # checks if atleast one version is published or not
  def is_published?
    versions.where(published: true).exists?
  end

  def published_version
    versions.where(published: true).first
  end

  def editing_version
    versions.where(editing: true).first
  end
  ###EDN of Version Management related stuff ********************* ----##


  ## protected methods ----------------------------------------- ##
  protected
  def create_default_version
    self.versions.create(number: 1)
  end



end
