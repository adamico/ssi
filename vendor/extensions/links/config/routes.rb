Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :links do
    resources :links, :path => '', :only => [:index, :show]
  end

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
