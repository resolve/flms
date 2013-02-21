Flms::Engine.routes.draw do
  # Default redirect after login.
  match 'admin' => 'admin#index', as: 'user_root'

  resources :pages
end
