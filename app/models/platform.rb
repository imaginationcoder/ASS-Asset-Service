class Platform
  include Mongoid::Document
  include Mongoid::Timestamps

  ## fields
  field :name #iOS , Android etc..

  ## Validations
  validates :name, presence: true, uniqueness: true


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
