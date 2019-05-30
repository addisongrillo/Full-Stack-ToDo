Rails.application.routes.draw do
  devise_for :users
  get 'hello_world', to: 'hello_world#index'
  root 'tasks#index'
  resources :tasks, only: [:create, :destroy, :update, :index] do
    resources :sub_tasks, only: [:index, :create, :update, :destroy], shallow: true
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
