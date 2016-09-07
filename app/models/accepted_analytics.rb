class AcceptedAnalytics < Analytics

  ##Fields
  field :is_accepted, type: Boolean

  ## Validations
  validates :is_accepted , presence: true

end
