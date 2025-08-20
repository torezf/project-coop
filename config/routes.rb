Rails.application.routes.draw do
  root "todolists#index"

  resources :todolists do
  end

  get "/brag" => "pages#index"
end
