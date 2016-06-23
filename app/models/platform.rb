class Platform
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## fields
  field :name #iOS , Android etc..

  ## Validations
  validates :name, presence: true, uniqueness:  { conditions: -> { where(deleted_at: nil) } }


  ## validations
  # validate do |platform|
  #   platform.errors.add :name, 'must be unique' if App.where(:id.ne => platform.app.id, "platforms.name" => platform.name).count > 0
  # end

  ## Indexes
  index({ name: 1 }, { unique: true })

  ## Associations
  embedded_in :app
  embeds_many :platform_categories, cascade_callbacks: true # iPad, iPhone etc for iOs

  ## scopes
  scope :default, -> { where(name: 'iOS').first }

end
