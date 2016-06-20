class Platform
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## fields
  field :name #iOS , Android etc..

  ## Validations
  validates :name, presence: true, uniqueness:  { conditions: -> { where(deleted_at: nil) } }


  ## Associations
  #embedded_in :app

  ## validations
  # validate do |platform|
  #   platform.errors.add :name, 'must be unique' if App.where(:id.ne => platform.app.id, "platforms.name" => platform.name).count > 0
  # end

  ## Indexes
  index({ name: 1 }, { unique: true })

  ## scopes
  scope :default, -> { where(name: 'iOS').first }

end
