Rails.application.routes.draw do
  get 'thanks', to: 'static#thanks'
  get 'privacy', to: 'static#privacy'
  root 'self_tests#new'
  resources :self_tests, only: %i[new index create] do
    collection do
      get 'wait'
    end
  end
end
