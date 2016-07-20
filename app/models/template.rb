class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  #TODO update below with its app version when documents are updated
  field :app_version, type: Integer, default: 1
  field :platform_category_id

  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy

  ## Association
  embeds_many :text_assets, cascade_callbacks: true
  embeds_many :button_actions, cascade_callbacks: true
  belongs_to :permission, index: true
  belongs_to :app, index: true

  accepts_nested_attributes_for :text_assets, allow_destroy: true,
                                reject_if: proc { |attributes| attributes['text'].blank? }
  accepts_nested_attributes_for :button_actions, allow_destroy: true,
                                reject_if: proc { |attributes| attributes['btn_type'].blank? }

  ## Scopes
  scope :by_permission, -> (permission) { where(permission: permission) }

  ## Callbacks

  # update app_version with current app editing version
  before_save do |document|
    document.app_version = document.app.editing_version.number
  end

end
