Brewzly::Application.routes.draw do
  root to: 'high_voltage/pages#show', id: 'home'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'sign_out', to: 'sessions#destroy', as: 'sign_out', via: [:get, :post]

end
