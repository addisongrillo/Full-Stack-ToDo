Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only: [:create, :destroy, :update] do
    resources :sub_tasks, only: [:index, :create, :update, :destroy], shallow: true
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
