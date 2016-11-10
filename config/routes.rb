Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: [:index, :show, :destroy]
  resources :items
  resources :item_histories, except: [:destroy, :edit, :update]
  resources :categories
  resources :brands
  resources :employees
  resources :systems
  resources :checkouts, except: [:destroy] do
    member do
      get 'checkin'
    end
  end
  resources :issues
  put 'toggle_status/:id', to: 'items#toggle_status', as: 'status_update'
  get 'history', to: 'items#history'
  post 'reallocate', to: 'items#reallocate'
  get 'deallocate', to: 'items#deallocate'
  get "/login", to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
  get 'systems/:id/history', to: 'systems#history', as: 'system_history'

end
