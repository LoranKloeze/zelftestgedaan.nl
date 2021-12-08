Rails.application.routes.draw do
  get 'thanks', to: 'static#thanks'
  get 'privacy', to: 'static#privacy'
  get 'too_soon', to: 'static#too_soon'
  get 'fake_exception', to: 'static#fake_exception'
  root 'self_tests#new'
  resources :self_tests, only: %i[new index create]
end
