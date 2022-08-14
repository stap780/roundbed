Rails.application.routes.draw do


  resources :infas do
		collection do
			get  :insales
			get  :download
			post :delete_selected
		end
	end
  	resources :bests do
		collection do
			get  :insales
			get  :download
			get  :update_price
			post :delete_selected
		end
	end
	resources :asabs do
		collection do
			post :import
			get  :insales
			get  :download
			post :delete_selected
		end
	end
	resources :marcs do
		collection do
			post :import
			get  :insales
			get  :image
			get  :desc
			post :delete_selected
		end
	end
	resources :cleos do
		collection do
			post :import
			get	 :download
			get  :insales
			post :delete_selected
		end
	end
	resources :alviteks do
		collection do
			post :import
			get	 :download
			get  :insales
			post :delete_selected
		end
	end
	resources :evateks do
		collection do
			post :import
			get :file_import
			get	 :download
			get  :insales
			post :delete_selected
		end
	end
	resources :laetes do
		collection do
			post :import
			get	 :download
			get  :insales
			post :delete_selected
		end
	end

	resources :permcls
	resources :permcl_actions
	resources :permissions
	get 'password_resets/new'
	
	get 'signup', to: 'users#newuser', as: 'signup'
	get 'login', to: 'sessions#new', as: 'login'
	get 'logout', to: 'sessions#destroy', as: 'logout'
	
	resources :password_resets
	resources :sessions
	resources :users
	resources :homes
	
	root :to => "homes#index"


end
