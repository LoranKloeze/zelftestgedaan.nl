Rails.application.routes.draw do
  get 'thanks', to: 'static#thanks'
  get 'static/privacy'
  root 'self_tests#new'
  resources :self_tests, only: %i[new index create]
end
