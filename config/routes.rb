Rails.application.routes.draw do
  resource :messages, only: %i[create]

  root 'home#index'
end
