Rails.application.routes.draw do
  devise_for :admins

  namespace :admin do
    root 'dashboard#index'
    resources :pages
    resources :services
    resources :testimonials
    resources :social_links
  end

  resources :contact_messages, only: %i[new create]
  root 'public#home'
  get '/about', to: 'public#about'
  get '/services', to: 'public#services'
  get '/testimonials', to: 'public#testimonials'
end