Rails.application.routes.draw do
  root "todolists#index"

  resources :todolists do
    member do
      patch :complete
    end
  end

  get "/brag" => "pages#index"
end
