class ButtonAction
  include Mongoid::Document


  field :text
  field :text_position , default: 'right'
  field :btn_type ,type: Integer,  default: 0  # 0: none , 1: text, 2: Image
  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy

  embedded_in :pre_prompt

end
