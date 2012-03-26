Refinery::Core::Engine.routes.append do

  get "/links" => "link_categories/link_categories#index"

  # Admin routes
  namespace :links, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :links, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :link_categories do
    resources :link_categories, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :link_categories, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :link_categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
