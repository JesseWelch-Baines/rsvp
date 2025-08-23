Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'application#main'

  devise_for :users

  resources :guests, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :guest_groups, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :guest_groupings, only: [] do
    collection do
      post :new
      post :destroy
    end
  end

  # Guest Group authentication
  get '/guest/:guest_group_id', to: 'guest_groups/sessions#new', as: 'guest_group_auth'
  post '/guest/:guest_group_id', to: 'guest_groups/sessions#create'
  delete '/guest/sign_out', to: 'guest_groups/sessions#destroy', as: 'destroy_guest_group_session'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
