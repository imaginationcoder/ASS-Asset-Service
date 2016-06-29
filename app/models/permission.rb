class Permission
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## Fields
  field :name # camera, location , push notification etc..
  field :abbreviation # CAM=> camera etc..



  def self.tour
    find_or_create_by(name: 'Tour')
  end

end
