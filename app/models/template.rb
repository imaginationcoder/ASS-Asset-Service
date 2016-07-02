class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  ## Fields
  #TODO update below with its app version when documents are updated
  field :version, type: Integer, default: 0

  ## Association
  embeds_many :text_assets, cascade_callbacks: true
  embeds_many :button_actions, cascade_callbacks: true
end
