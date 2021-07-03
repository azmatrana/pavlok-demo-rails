Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'auth#index'
  get 'auth/pavlok/result' => 'auth#index'
  get 'reuse' => 'auth#reuse_token'

end
