Refinery::Core::Engine.routes.append do

  get "/program" => "schools/schools#show"
  get "/previous" => "schools/schools#index"
  get '/registration' => 'registrations/registrations#new'

  get '/payment_callback' => "registrations/paybox#ipn"
  get '/payment_accepted' => "registrations/paybox#accepted"
  get '/payment_refused' => "registrations/paybox#refused"
  get '/payment_canceled' => "registrations/paybox#canceled"

  # Frontend routes
  namespace :schools do
    resources :schools, :path => '', :only => [:index, :show]
  end

  namespace :registrations do
    resources :registrations, :path => '', :only => [:new, :create, :edit, :update]
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


  # Admin routes
  namespace :registrations, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :registrations, :except => [:show, :new, :create] do
        collection do
          post :update_positions
        end
      end
    end
  end

end
