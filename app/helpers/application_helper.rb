module ApplicationHelper

  #the form calls helpers which are specified by Devise and so aren't present when you access a Devise form from a non-Devise controller.
  #To get around this, need to add the following methods to the helper class of the controller you wish to display the form under.
  # Alternatively, we can just add them to application helper to make them available anywhere.
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
