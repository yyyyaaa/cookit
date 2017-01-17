Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'comments/new'
  get 'comments/create'

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout", registration: "register"},
                      controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :users do
    member do
      get "myrecipes", to: "recipes#myrecipes"
    end
  end
  resources :recipes do
    resources :comments
    member do
      put "upvote", to: "recipes#upvote"
      put "downvote", to: "recipes#downvote"
    end
  end

  root 'recipes#index'
end
