Rails.application.routes.draw do

  resources :static_pages
  resources :course_aliases
  resources :course_names
  resources :seats
  resources :courses do
    member do
      post :buy
    end
  end
  resources :providers
  resources :purchases, only: [:show, :index]
  devise_for :users, controllers: {registrations: "registrations"}
  resources :users do
    member do
      put :approve
    end
  end

  devise_scope :user do
      authenticated :user do
        root 'courses#index', as: :authenticated_root
        #root 'static_pages#landing'
      end
    end
  #root 'static_pages#landing'
  root 'devise/sessions#new'


  # This is necessary because devise takes over control of the
  # Normal path. This allows the admin to create a user without
  # loging in

  post '/create_user_no_devise', to: 'users#create'
  patch '/update_user_no_devise/:id', to: 'users#update'
  patch '/changepw', to: 'users#changepw'


  get  '/cities_by_province', to: 'cities#by_province'
  get ':id/:model/:type/:id_image/:uploader/serve_image', to: 'images#serve_image'




  #get  '/home', to: 'static_pages#home'
  get  '/home', to: 'static_pages#landing'
  get  '/aboutus', to: 'static_pages#aboutus'
  get  '/partners', to: 'static_pages#partner'
  get  '/providerfaq', to: 'static_pages#providerfaq'
  get  '/opportunities', to: 'static_pages#opportunity'
  get  '/contact', to: 'static_pages#contact'
  post '/contact', to: 'static_pages#contact'
  get  '/try_the_beta', to: 'static_pages#beta'

end
