class Version
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Paranoia

  ## Fields ---------------------------------------------- ###
  field :number , type: Integer
  field :editing, type: Boolean, default: true
  field :published, type: Boolean, default: false
  field :published_at, type: Time, default: nil

  ## validations  ---------------------------------------- ###
  validates :number, presence: true, uniqueness: true

  ## Associations  ---------------------------------------- ###
  embedded_in :app



  # after publish update published=> true and editing=> false and create another version with count+1(unless same version exists)
  # and create all templates with new version(editing one)


end
