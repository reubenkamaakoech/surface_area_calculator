Rails.application.routes.draw do
  resources :sections
    resources :rooms
  resources :area_types
  resources :sites
  devise_for :users, controllers: {
  registrations: "users/registrations"
  }

   resources :users do
    member do
      patch :toggle_access
       patch :toggle_status
    end
  end

  devise_scope :user do
    get "sign_out", to: "devise/sessions#destroy"
  end

  post "/toggle_sign_ups", to: "settings#toggle_sign_ups", as: "toggle_sign_ups"
  
  get "home/index"
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
   
end
