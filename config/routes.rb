Rails.application.routes.draw do
  get 'sandbox/index'
  scope '/api' do
    resources :votes, only: [:create]
  end
  
  scope '/admin' do
    resources :votes, only: [:index, :show]
  end
  
  resources :iframes, only: [:index] do
    collection do
      get :test
    end 
  end
end
