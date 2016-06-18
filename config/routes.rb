Rails.application.routes.draw do
  get 'home/index'

  use_doorkeeper
  devise_for :users
  root :to => 'home#index'

  ## dev app's dashboard
  get 'my-apps' => 'apps#index', as: :my_apps
  resources :apps ,except: [:index]


  ## API --------------------------------
  namespace :api , defaults: {format: :json} do
    #version 1
    namespace :v1 do

      devise_scope :user do
        post 'authorize_app' => 'sessions#authorize_app'
        #delete 'logout' => 'sessions#destroy'
      end

      get 'tour'=>"tour#index"
    end
  end



  scope 'api' do
    use_doorkeeper :scope=>'clients' do
      # it accepts :authorizations, :tokens, :applications and :authorized_applications
      #controllers :applications => 'admin/api_provider'
    end
  end

end
