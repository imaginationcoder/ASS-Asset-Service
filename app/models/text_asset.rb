class TextAsset
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  field :text
  field :position

  ## Constants
  POSITIONS = %w(top-left top-center top-right center-left center-center
                 center-right bottom-left bottom-center bottom-right)

  ## embedded_in :template
  embedded_in :template

end
