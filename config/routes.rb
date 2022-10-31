Rails.application.routes.draw do
  root "tasks#index"
  get "/" => "tasks#index"
  resources :tasks
  #   collection do
  #     get 'search' => 'tasks#search'
  #   end
  # end
end
