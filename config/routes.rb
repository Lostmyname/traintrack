Rails.application.routes.draw do

  devise_for :people, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }

  resources :people
  resources :expenses

  get '/stats' => 'stats#index'

  root 'home#index'

  devise_scope :person do
    get '/sign_out', to: 'devise/sessions#destroy'
  end

end
