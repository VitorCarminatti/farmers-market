Rails.application.routes.draw do
  root 'pages#home'
  get  'pages/products', to: 'pages#get_products'
  post 'pages/totalize_products', to: 'pages#totalize_products'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
