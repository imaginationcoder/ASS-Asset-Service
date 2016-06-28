class Platform
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## fields
  field :name #iOS , Android etc..

  ## Validations
  validates :name, presence: true,  uniqueness: true#, uniqueness:  { conditions: -> { where(deleted_at: nil) } }


  ## validations
  # validate do |platform|
  #   platform.errors.add :name, 'must be unique' if App.where(:id.ne => platform.app.id, "platforms.name" => platform.name).count > 0
  # end

  ## Indexes
  index({ name: 1 }, { unique: true })

  ## Associations
  embeds_many :platform_categories, cascade_callbacks: true # iPad, iPhone etc for iOs
  #has_and_belongs_to_many :apps
  has_many :apps

  ## scopes
  #scope :default, -> { where(name: 'iOS').first }

  def self.default
    find_or_create_by(name: 'iOS')
  end
end
