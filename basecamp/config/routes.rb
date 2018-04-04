Rails.application.routes.draw do
  get 'projects/index'

  resources :projects, only: [:index, :show], shallow: true do
    resources :messages
    resources :comments
  end
  
  resources :users
  
  get 'progress' => 'progress#show'
  get 'search' => 'search#index', as: :search
  
  root to: 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
