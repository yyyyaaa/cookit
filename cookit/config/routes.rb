Rails.application.routes.draw do
  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout", registration: "register"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :recipes
  root 'recipes#index'
end
