class App
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Fields
  field :name
  field :app_id , type: Integer # 16 digit unique integer
  field :client_id #unique
  field :secret_token #unique


  ## Associations
  belongs_to :user
  embeds_many :platforms, cascade_callbacks: true


end
