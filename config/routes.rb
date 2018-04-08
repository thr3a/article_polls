Rails.application.routes.draw do
  
  root "votes#index"
  
  scope '/api' do
    resources :votes, only: [:create]
  end
  
  resources :votes, only: [:index, :show]
  
  resources :iframes, only: [:index] do
    collection do
      get :test
    end 
  end
end
