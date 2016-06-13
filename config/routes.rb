Rails.application.routes.draw do
  get 'home/index'

  use_doorkeeper
  devise_for :users
  root :to => 'home#index'


  ## API --------------------------------
  namespace :api , defaults: {format: :json} do
    #version 1
    namespace :v1 do
      get 'tour'=>"tour#index"
    end
  end

end
