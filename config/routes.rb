Rails.application.routes.draw do
  
  resources :folders

  scope module: :api, defaults: { format: 'json' } do

    namespace :v1 do

      namespace :posts do
        resources :nearests, only: [:index]
      end
      resources :posts, only: [:show, :create, :update] do
         resources :likes, only: [:index]
      end

      resources :users, only: [:show, :create, :update, :index] do
        resources :posts, only: [:index]
      end

      resources :folders, only: [:create, :update, :index, :destroy]
      resources :sessions, only: [:create, :destroy]
    end
  
  end

end
