class Platform
  include Mongoid::Document
  include Mongoid::Timestamps

  ## fields
  field :name #iOS , Android etc..

  ## Validations
  validates :name, presence: true, uniqueness: true


  ## Associations
  #embedded_in :application

  ## validations
  # validate do |platform|
  #   platform.errors.add :name, 'must be unique' if Application.where(:id.ne => platform.application.id, "platforms.name" => platform.name).count > 0
  # end

  ## Indexes
  index({ name: 1 }, { unique: true })

end
