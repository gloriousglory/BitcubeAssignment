Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home', as: 'home'

  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  # devise_scope :user do
  #   get 'login', to: 'users/sessions#new', as: 'login'
  #   post 'login', to: 'users/sessions#create', as: 'new_session'
  # end

  # User Actions
  get 'users/new_user', to: 'users#new', as: 'new_user'
  post 'users/create_user', to: 'users#create', as: 'create_user'
  get 'users/edit_password', to: 'users#edit_password', as: 'edit_password'
  patch 'users/edit_password', to: 'users#update_password', as: 'update_password'
  get 'users/:id', to: 'users#show', as:'view_profile'
  get 'users/edit/:id', to: 'users#edit', as: 'edit_profile'
  patch 'users/edit/:id', to: 'users#update', as: 'update_profile'

  # Friends Page
  get 'friends_page/index', to: 'friends_page#index', as: 'all_users'
end
