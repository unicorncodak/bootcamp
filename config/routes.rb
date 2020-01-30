Rails.application.routes.draw do
  resources :tasks
  resources :teams
  resources :comments
  resources :custom_threads
  resources :admincontrols
  resources :projects do
    collection do
      get :dashboard
      post :upload
      delete :destroyattachment
    end
  end
  resources :students
  get 'login', to: 'sessions#new', as: 'login'
  get 'sessions/create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  resources :users do
    collection do
      get :role
      get :delete
      get :admin
      get :profile
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'projects#dashboard'
end
