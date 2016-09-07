class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  field :app_version, type: Integer, default: 1
  field :platform_category_id
  ## below field is to check whether this template creating from when version is publishing
  field :via_publishing , type: Boolean, default: false
  field :is_tour , type: Boolean , default: false


  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy

  ## Association
  embeds_many :text_assets, cascade_callbacks: true
  embeds_many :button_actions, cascade_callbacks: true
  belongs_to :permission, index: true
  belongs_to :app, index: true
  has_many :analytics

  ## Indexes ----------------------------------------- ##
  index({ app_version: 1 })
  index({ app_id: 1, app_version: 1, permission_id: 1 })
  index "button_actions.btn_type" => 1

  accepts_nested_attributes_for :text_assets, allow_destroy: true,
                                reject_if: proc { |attributes| attributes['text'].blank? }
  accepts_nested_attributes_for :button_actions, allow_destroy: true,
                                reject_if: proc { |attributes| attributes['btn_type'].blank? }

  ## Scopes
  scope :by_permission, -> (permission) { where(permission: permission) }

  ## instance methods
  def average_time_spent(version)
    avg = analytics.where(_type: 'TimedAnalytics', app_version: version).avg(:time_spent)
    '%.1f' % avg.to_f #rescue 0.0
  end

  # total people accepted by a permission asset
  def permission_accepted_count(version)
    analytics.where(_type: 'AcceptedAnalytics', app_version: version, is_accepted: true).count
  end

  # total people denied by a permission asset
  def permission_denied_count(version)
    analytics.where(_type: 'AcceptedAnalytics', app_version: version, is_accepted: false).count
  end

  ## Callbacks

  # update app_version with current app editing version
  before_create do |document|
    # don't assign app_version if it is creating when app version is published
     unless document.via_publishing.eql?(true)
       document.app_version = document.app.editing_version.number
       document.unset(:via_publishing)
     end
  end

end
