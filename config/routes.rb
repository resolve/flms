Flms::Engine.routes.draw do
  devise_for :user,
             class_name: 'Flms::User',
             module: :devise,
             controllers: { sessions: 'flms/sessions',
                            passwords: 'flms/passwords' },
             path_names: { sign_out: 'logout' }

  devise_scope :user do
    get '/login' => 'sessions#new', :as => :login
    post '/login' => 'sessions#create'
  end

  # Default redirect after login.

  resources :pages
  resources :users, only: [:index, :new, :create, :destroy]
end
