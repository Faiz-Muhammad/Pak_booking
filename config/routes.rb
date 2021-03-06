Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :hotels
      resources :rooms
      resources :bookings
      get '/available_rooms/', to: 'bookings#available_rooms'
    end
  end

  root to: 'api/v1/hotels#index'
end
