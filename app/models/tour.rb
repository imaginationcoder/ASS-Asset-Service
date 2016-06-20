class Tour
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  field :name

  ## Validations
  validates :name, presence: true
  validates :app, associated: true

  ## Associations
  belongs_to :app, index: true
  embeds_many :guides, cascade_callbacks: true

end
