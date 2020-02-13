Rails.application.routes.draw do
  resources :messages, only: %i[index create]

  get '/check', to: proc { [200, {}, ['Hello world!']] }
end
