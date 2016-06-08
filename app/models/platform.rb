class Platform
  include Mongoid::Document
  include Mongoid::Timestamps

  ## fields
  field :name #iOS , Android etc..

  ## Validations
  validates :name, presence: true, uniqueness: true


  ## Associations
  belongs_to :app

end
