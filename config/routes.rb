Rails.application.routes.draw do
  get 'carts/update'
  get 'carts/show'
  post '/rate' => 'rater#create', :as => 'rate'
  resources :menus
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :recipes
  resource :cart, only: %i[show update] do
    member do
      post :pay_with_paypal
      get :process_paypal_payment
    end
  end
  post 'recipes/:id/favorite', to: 'recipes#favorite', as: 'recipe_like'
  post 'recipes/:id/add_to_cart', to: 'recipes#add_to_cart', as: 'recipe_add_cart'
  post 'recipes/:id/rate', to: 'recipes#rate', as: 'recipe_rate'
  get 'pages/index'
  get "/your-profile", to: "pages#profile"
  get '/your-favorites', to: 'pages#favorites'
  get '/your-orders', to: 'pages#orders'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
end
