Dashbozu2::Application.routes.draw do
  resources :activities

  get "top/index"
  get "projects/from_service/:provider(/:owner)", controller: "projects", action: "from_service", as: "projects_from_service"
  post "projects/toggle/:provider/*name", controller: "projects", action: "toggle", as: "toggle_project"
  resources :projects
  get "profile/show"

  root to: 'top#index'

  devise_for :users, controllers: { omniauth_callbacks: 'authentication' }
  devise_scope :user do
    get 'sign_in', to: 'authentication#login', as: :new_user_session
    delete 'sign_out', to: 'authentication#logout', as: :destroy_user_session
  end
  get ':controller/:action', controller: 'authentication'

  post 'hook/:api_key/*name', to: 'hook#hook', as: :hook_path
end
