Dashbozu2::Application.routes.draw do
  get "top/index"
  root to: 'top#index'

  get "activities", controller: "activities", action: "all", as: "all_activities"
  get "activities/:id/embed", controller: "activities", action: "embed", as: "activity_embed"
  resources :activities

  get "projects/from_service/:provider(/:owner)", controller: "projects", action: "from_service", as: "projects_from_service"
  get "projects/:api_key/activities", controller: "activities", action: "index", as: "project_activities"
  post "projects/toggle/:provider/*name", controller: "projects", action: "toggle", as: "toggle_project"
  resources :projects

  get "profile/show"

  devise_for :users, controllers: { omniauth_callbacks: 'authentication' }
  devise_scope :user do
    get 'sign_in', to: 'authentication#login', as: :new_user_session
    delete 'sign_out', to: 'authentication#logout', as: :destroy_user_session
  end
  get ':controller/:action', controller: 'authentication'

  post 'hook/:api_key/*name', to: 'hook#hook', as: :hook_path
end
