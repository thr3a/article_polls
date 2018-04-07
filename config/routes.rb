Rails.application.routes.draw do
  get 'sandbox/index'
  scope '/api' do
    resources :votes, only: [:create]
  end
  
  scope '/admin' do
    resources :votes, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
