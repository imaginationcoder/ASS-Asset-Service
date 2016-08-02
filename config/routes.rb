Rails.application.routes.draw do
  get 'home/index'

  use_doorkeeper
  devise_for :users
  root :to => 'home#index'

  ## dev app's dashboard
  get 'my-apps' => 'apps#index', as: :my_apps
  resources :apps ,except: [:index] do
    resources :templates , shallow: true
    member do
      get 'tour/new' => 'tour#new',as: :new_tour
      post 'tour' => 'tour#create',as: :create_tour
      get 'tour' => 'tour#index'
      get 'tour/edit' => 'tour#edit', as: :edit_tour
      put 'tour' => 'tour#update', as: :update_tour
      resources :versions,only: [:index,:destroy]  do
        post 'publish'=> "versions#publish"
        get 'preview'=> 'versions#preview', as: :preview
      end
      resources :analytics,only: [:index,:show]
    end
  end
  ## Profile
  get 'profile'=>"profile#index", as: :profile
  put 'profile/update'=>"profile#update", as: :update_profile
  put 'update_avatar'=> "profile#update_avatar", as: :update_avatar
  put 'update_password'=> "profile#update_password", as: :update_password

  ## API --------------------------------
  namespace :api , defaults: {format: :json} do
    #version 1
    namespace :v1 do

      devise_scope :user do
        post 'authorize_app' => 'sessions#authorize_app'
        #delete 'logout' => 'sessions#destroy'
      end

      get 'tour/assets'=>"tour#index"
      get 'permission/:name/assets'=>"permissions#index"
    end
  end



  scope 'api' do
    use_doorkeeper :scope=>'clients' do
      # it accepts :authorizations, :tokens, :applications and :authorized_applications
      #controllers :applications => 'admin/api_provider'
    end
  end

end
