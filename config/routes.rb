Rails.application.routes.draw do
  root "todolists#index"
  resources :todolists
  get "/brag" => "pages#index"
end
