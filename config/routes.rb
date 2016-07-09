Rails.application.routes.draw do
  root "rents#new"
  resources :rents do
    member do
      post :pay2go_cc_notify
      get :redirecting
      get :result
    end
  end
end
