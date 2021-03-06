class Permission
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## Fields
  field :name # camera, location , push notification etc..
  field :abbreviation # CAM=> camera etc..
  field :description
  field :pro_tip

  ## Indexes
  index({ name: 1 }, { unique: true})

  def self.tour
    find_or_create_by(name: 'Tour')
  end

end
