Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  resources :users, only: [:index, :show, :destroy]
  resources :items
  resources :categories
  resources :brands
  get 'history', to: 'items#history'
  post 'reallocate', to: 'items#reallocate'
  get 'deallocate', to: 'items#deallocate'
end
