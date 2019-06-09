Rails.application.routes.draw do
  resources :firms, only: [:new, :edit, :update, :create, :show, :index]
  #get 'landing/index'
  #get 'quotations/index'
  #get 'quotations/new'
  #get 'quotations/create'
  #get 'quotations/show'
  #get 'product_associates/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get '/products', to: 'products#index'
  #get 'products/:id', to: 'products#show'
  resources :products do
    collection { post :import }
  end
  resources :email_messages#, only: [:new, :create, :show, :index]
  #resources :quotations
  resources :youtube_videos
  #resources :connections
  #resources :reserved_relations
  resources :contact_messages, only: [:new, :create]
  resources :events, only: [:new, :create]
 


  #get '/product_associates', to: 'product_associates#index'

  #resources :chat_rooms, only: [:new, :create, :show, :index]
  #root 'chat_rooms#index'  

  #resources :messages

  #resources :customer_to_bankers

  #resources :dark_orders

  mount ActionCable.server => '/cable'

  get '/users',   to: 'users#index'

 # get '/users/:id',   to: 'users#show'

  devise_for :users, controllers: { registrations: "registrations" }

  authenticated do
    root :to => 'products#index', as: :authenticated_root
  end

  root  to: 'landing#index'  
#  !authenticated do
#    root  to: 'landing#index'  
#  end


  get '/landing', to: "landing#index"
  get '/preco_fertilizacaoinvitro', to: "landing#preco_fertilizacao_in_vitro"  
  get '/preco_inseminacao_artificial', to: "landing#preco_inseminacao_artificial"  
  get '/preco_relacao_sexual_programada', to: "landing#preco_relacao_sexual_programada"  
  get '/preco_transferencia_de_embriao_congelado', to: "landing#preco_transferencia_de_embriao_congelado"  
  get '/preco_doacao_de_embriao', to: "landing#preco_doacao_de_embriao"  

  get '/preco_doacao_de_ovulos', to: "landing#preco_doacao_de_ovulos"  

  get '/preco_barriga_de_aluguel', to: "landing#preco_barriga_de_aluguel"  
  get '/preco_doacao_de_semen', to: "landing#preco_doacao_de_semen"  
  get '/preco_congelamento_de_ovulos', to: "landing#preco_congelamento_de_ovulos"  




  #resources :product_associates, only: [:new, :create, :index]

  resources :categories, only:[:new,:create]
  resources :assetclasses, only:[:new,:create]  
  resources :product_articles


  #resources :posts

  get 'user/:id' => 'users#show', as: :user

  #get '/request_tutorial', to: 'tutorials#request_tutorial'

end
