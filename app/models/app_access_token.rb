class AppAccessToken
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## fields
  field :access_token

  ## Validations
  validates :access_token, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates :app, associated: true

  ## Associations
  belongs_to :app, index: true

  ## Indexes

  #index({access_token: 1, app_id: 1}, { unique: true, drop_dups: true})

end
