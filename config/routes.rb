Rails.application.routes.draw do
  root 'self_tests#index'
  resources :self_tests
end
