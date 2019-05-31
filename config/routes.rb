Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'

  resources :tasks, only: [:create, :destroy, :update, :index] do
    resources :sub_tasks, only: [:index, :create, :update, :destroy], shallow: true
  end

  resource :calendar, only: [:show]
end
