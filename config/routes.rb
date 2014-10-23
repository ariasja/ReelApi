Rails.application.routes.draw do
  
  resources :videos

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
        resources :folders, only: [:index]        
        member do
          get :following, :followers, :feed_posts
        end
      end

      resources :relationships, only: [:create, :destroy]
      get 'relationships/is_valid_relationship', to: 'relationships#show'
      delete 'relationships', to:'relationships#destroy'

      resources :folders, only: [:create, :update, :index, :destroy] do
        get 'posts', to: 'posts#indexByFolderId'
      end

      resources :sessions, only: [:create, :destroy]
    end
  
  end

end
