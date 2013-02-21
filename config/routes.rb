Flms::Engine.routes.draw do
  devise_for :users,
             module: :devise,
             #class_name: 'User',
             controllers: { sessions: 'sessions', passwords: 'passwords' }
  # Default redirect after login.
  match 'admin' => 'admin#index', as: 'user_root'

  resources :pages
  resources :users, only: [:index, :new, :create, :destroy]
end
