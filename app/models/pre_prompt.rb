class PrePrompt
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  POSITIONS = %w(left right center top bottom)

  ## Fields
  field :heading
  field :content
  field :content_position, default: POSITIONS.first
  field :heading_position, default: POSITIONS.first
  #field :source_processing,type: Boolean ,default: false

  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy
  #process_in_background :source

  ## Associations
  belongs_to :permission, index: true
  belongs_to :app, index: true
  embeds_many :button_actions, cascade_callbacks: true
  #embedded_in :tour

  accepts_nested_attributes_for :button_actions, allow_destroy: true,reject_if: proc { |attributes| attributes['btn_type'].blank? }


end
