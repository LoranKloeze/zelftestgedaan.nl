Rails.application.routes.draw do
  root 'self_tests#new'
  resources :self_tests, only: [:new, :index]
end
