Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: [:create, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
