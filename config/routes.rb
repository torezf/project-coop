Rails.application.routes.draw do
  root "todolists#index"

  resources :todolists

  get "/brag" => "pages#index"

  match "*path", to: redirect("/"), via: :all
end
