require "sidekiq/web"
Sidekiq::Web.app_url = "/"

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'
  namespace :admin do
    get '/sign_in', to: "sign_ins#new", as: :admin_sign_in
    resource :sign_ins, only: [:create, :destroy]
    resources :product_urls, except: [:index]
  end

  authenticated :user do
    root 'product_urls#index', as: :user_root
  end
  root 'home#index'
  resources :home, only: [:show]
end
