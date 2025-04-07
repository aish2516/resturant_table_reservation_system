Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :api do
  #   namespace :v1 do

  #     # Tables Routes
  #     resources :tables do
  #       collection do
  #         get 'filter' # /api/v1/tables/filter?capacity=4&location=indoor
  #       end
  #     end

  #     # Time Slots (Fixed 2-hour blocks like 10–12, 12–2, etc.)
  #     resources :time_slots, only: [:index]

  #     # Reservations
  #     resources :reservations do
  #       member do
  #         delete 'cancel' # /api/v1/reservations/:id/cancel
  #       end

  #       collection do
  #         get 'available_slots' # /api/v1/reservations/available_slots?date=2025-04-08&guest_count=4
  #         post 'smart_assign'   # /api/v1/reservations/smart_assign
  #       end
  #     end
  #   end
  # end
  # config/routes.rb


  resources :tables do
    collection do
      get :filter
    end
  end

  resources :reservations do
    collection do
      get :available_slots
    end
  end

  root to: "home#index" # Optional UI entry point if using Hotwire or plain views
end
