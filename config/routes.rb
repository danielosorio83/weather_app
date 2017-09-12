Rails.application.routes.draw do
  get '/weather', to: 'weather#index'
  
  root 'root#index'
end
