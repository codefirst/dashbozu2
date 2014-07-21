Dashbozu2::Application.routes.draw do
  get "top/index"
  root to: 'top#index'

  get "activities", controller: "activities", action: "all", as: "activities"
  get "activities/:id", controller: "activities", action: "show", as: "activity"
  get "activities/:id/embed", controller: "activities", action: "embed", as: "activity_embed"

  get "projects", controller: "projects", action: "index", as: "projects"
  get "projects/from_service/:provider(/:owner)", controller: "projects", action: "from_service", as: "projects_from_service"
  get "projects/:api_key/hooks", controller: "projects", action: "hooks", as: "project_hooks"
  get "projects/:api_key/activities", controller: "activities", action: "index", as: "project_activities"
  get "user/activities", controller: "activities", action: "user", as: "user_activities"
  post "projects/toggle/:provider/*name", controller: "projects", action: "toggle", as: "toggle_project"

  get "profile/show"
  get "profile/hooks", as: "profile_hooks"

  devise_for :users, controllers: { omniauth_callbacks: 'authentication' }
  devise_scope :user do
    get 'sign_in', to: 'authentication#login', as: :new_user_session
    delete 'sign_out', to: 'authentication#logout', as: :destroy_user_session
  end
  get ':controller/:action', controller: 'authentication'

  post 'hook/:api_key/*name', to: 'hook#hook', as: :hook
  get 'hook/:api_key/*name', to: 'hook#hook'
end
