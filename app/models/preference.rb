class Preference
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## Fields
  field :name # camera, location , push notification etc..
  field :abbreviation # CAM=> camera etc..



  def self.tour
    where(name: 'Tour').first
  end

end
