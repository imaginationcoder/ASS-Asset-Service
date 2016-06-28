class ButtonAction
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  field :text
  field :text_position , default: 'right'
  field :btn_type ,type: Integer,  default: 0  # 0: none , 1: text, 2: Image
  ## Uploader
  mount_uploader :source, AssetUploader, dependent: :destroy

  embedded_in :pre_prompt
  before_save :check_btn_type

  def check_btn_type
    # remove other unused elements before saving to db based on btn_type
    case self.btn_type
      when 0
        self.unset(:text, :text_position, :source)
      when 1
        self.unset(:source)
      when 2
        self.unset(:text, :text_position)
    end
  end

end
