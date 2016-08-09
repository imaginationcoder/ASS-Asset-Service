class Identity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String


  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  ## Indexes
  index({ provider: 1, uid: 1 })

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

end
