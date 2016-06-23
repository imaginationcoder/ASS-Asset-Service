class ButtonAction
  include Mongoid::Document


  field :btn_text
  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy



end
