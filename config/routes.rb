Rails.application.routes.draw do
  resource :messages, only: %i[create]

  get '/check', to: proc { [200, {}, ['Hello world!']] }
end
