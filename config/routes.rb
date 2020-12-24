Rails.application.routes.draw do
  root "sessions#new"

  get    'account/new'                    , to: "accounts#new"
  post   'account/new'                    , to: "accounts#create"
  get    'account/:type/view/:id'         , to: "accounts#show"
  post   'account/:type/transfer_slc/:id' , to: "accounts#transfer_selection"
  post   'account/:type/transfer/:id'     , to: "accounts#transfer"
  delete "account/:type/del/:id"          , to: "accounts#destroy"
  post   "/login"                         , to: 'sessions#create'
  delete "/logout"                        , to: 'sessions#destroy'
  get    "/user/register"                 , to: 'users#new'
  post   "/user/register"                 , to: "users#create"
  get    "/user/profile/:id"              , to: 'users#show'
  get    "/user/profile/:id"              , to: 'users#edit'
  post   "/user/profile/:id"              , to: 'users#update'
  delete "/user/profile/:id"              , to: 'users#destroy'
end
