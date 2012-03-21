Refinery::Core::Engine.routes.append do

  get "/program" => "schools/schools#next"
  get "/previous" => "schools/schools#index"

  # Frontend routes
  namespace :schools do
    resources :schools, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :schools, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :schools, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Admin routes
  namespace :events, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
