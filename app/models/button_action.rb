class ButtonAction
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  field :label
  field :target_event
  field :btn_type ,type: Integer,  default: 1  # 0: none , 1: text, 2: Image
  ## Uploader
  mount_uploader :source, ButtonUploader, dependent: :destroy

  embedded_in :template
  before_save :check_btn_type

  def check_btn_type
    # remove other unused elements before saving to db based on btn_type
    case self.btn_type
      when 0
        self.unset(:label, :target_event, :source)
      when 1
        self.unset(:source)
      when 2
        self.unset(:label)
    end
  end

end
