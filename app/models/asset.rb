class Asset
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Fields
  #field :source_processing,type: Boolean ,default: false
  field :heading
  field :sub_text

  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy
  #process_in_background :source

  ## Associations
  embedded_in :tour
end
