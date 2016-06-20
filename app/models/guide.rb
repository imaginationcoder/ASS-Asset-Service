class Guide
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  #field :source_processing,type: Boolean ,default: false
  field :heading
  field :description

  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy
  #process_in_background :source

  ## Associations
  embedded_in :tour
end
