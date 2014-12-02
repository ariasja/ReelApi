Rails.application.routes.draw do
  resources :attags

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
        get 'posts', to: 'posts#index_by_folder_id'
      end

      resources :sessions, only: [:create, :destroy]
      resources :videos, only: [:create, :destroy, :index]
      get 'video_with_post_id/:post_id', to:'videos#show'
      resources :folders
      resources :hashtags, only: [:index, :show, :create, :destroy]
      get 'hashtags/with_tag/:tag', to:'posts#hashtags_index_by_tag'
      get 'hashtags/with_tag/:tag/by_tagging_user/:user_id', to:'posts#hashtags_index_by_tag_and_by_user'

      resources :attags, only: [:index, :show, :create, :destroy]
      get 'attags/tagging_user/:user_id', to: 'posts#attags_index_by_tagging_user'
      get 'attags/tagged_user/:user_id', to: 'posts#attags_index_by_tagged_user'
    
    end
  end
end
