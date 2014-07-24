Rails.application.routes.draw do
  
  scope module: :api, defaults: { format: 'json' } do

    namespace :v1 do

      namespace :posts do
        resources :nearests, only: [:index]
      end

      resources :posts, only: [:show, :create, :update]

      resources :users, only: [:show, :create, :update]
      
    end
  
  end

end
