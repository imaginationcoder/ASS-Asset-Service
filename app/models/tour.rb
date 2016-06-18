class Tour
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Fields
  field :name

  ## Validations
  validates :name, presence: true
  validates :app, associated: true

  ## Associations
  belongs_to :app, index: true
  embeds_many :assets, cascade_callbacks: true

end
