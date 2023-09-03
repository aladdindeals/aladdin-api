require "sidekiq/web"
Sidekiq::Web.app_url = "/"

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'
  resources :product_urls, except: [:index]
  resource :sign_ins, only: [:create, :destroy]
  authenticated :user do
    root 'product_urls#index', as: :user_root
  end

  root "sign_ins#new"
end
