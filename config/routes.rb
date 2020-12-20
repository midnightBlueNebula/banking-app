Rails.application.routes.draw do
  get    'accounts/new'                , to: "accounts#new"
  post   'accounts/new'                , to: "accounts#create"
  get    'accounts/:type/view/:id'     , to: "accounts#show"
  delete "accounts/:type/del/:id"      , to: "accounts#destroy"
  get    "/login"                      , to: 'sessions#new'
  post   "/login"                      , to: 'sessions#create'
  delete "/logout"                     , to: 'sessions#destroy'
  get    "/user/register"              , to: 'users#new'
  post   "/user/register"              , to: "users#create"
  get    "/user/profile/:id"           , to: 'users#show'
  get    "/user/profile/:id"           , to: 'users#edit'
  post   "/user/profile/:id"           , to: 'users#update'
  delete "/user/profile/:id"           , to: 'users#destroy'
end
