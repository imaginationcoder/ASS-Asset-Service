class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## Fields
  field :number , type: Integer
  field :published, type: Boolean, default: false
  field :published_at, type: Time

  ## Associations
  embedded_in :app

  ## validations
  validates :number, presence: true, uniqueness: true

end
