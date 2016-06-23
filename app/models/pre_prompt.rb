class PrePrompt
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  POSITIONS = %w(left right center top bottom)

  ## Fields
  field :header
  field :footer
  field :content
  field :content_position, default: POSITIONS.first
  #field :source_processing,type: Boolean ,default: false

  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy
  #process_in_background :source

  ## Associations
  belongs_to :preference
  belongs_to :app
  embeds_many :button_actions, cascade_callbacks: true
  #embedded_in :tour

end
