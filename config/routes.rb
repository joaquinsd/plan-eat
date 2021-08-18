Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :menus
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :recipes
  post 'recipes/:id/favorite', to: 'recipes#favorite', as: 'recipe_like'
  post 'recipes/:id/rate', to: 'recipes#rate', as: 'recipe_rate'
  get 'pages/index'
  get "/your-profile", to: "pages#profile"
  get '/your-favorites', to: 'pages#favorites'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
end
