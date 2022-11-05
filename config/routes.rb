Rails.application.routes.draw do
  root "users#new"
  get "/" => "tasks#index"
  resources :tasks
  #   collection do
  #     get 'search' => 'tasks#search'
  #   end
  # end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  resources :labels
end
