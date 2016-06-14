class AppAccessToken
  include Mongoid::Document
  include Mongoid::Timestamps

  ## fields
  field :access_token

  ## Validations
  validates :access_token, presence: true, uniqueness: true
  validates :application, associated: true

  ## Associations
  belongs_to :application, index: true

  ## Indexes

  #index({access_token: 1, application_id: 1}, { unique: true, drop_dups: true})

end
