Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :payments, only: [:show, :create]
    end
  end
end
