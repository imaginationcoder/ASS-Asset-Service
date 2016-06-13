class Tour
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Fields
  field :name

  ## Validations
  validates :name, presence: true
  validates :application, associated: true

  ## Associations
  belongs_to :application, index: true
  embeds_many :assets, cascade_callbacks: true

end
