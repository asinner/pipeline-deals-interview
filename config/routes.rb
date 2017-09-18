Rails.application.routes.draw do
  root 'static_pages#home'

  namespace :api, defaults: { format: :json } do
    resources :deals, only: %i(index)
  end
end
