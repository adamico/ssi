module Refinery
  module Registrations
    module Admin
      class RegistrationsController < ::Refinery::AdminController
        before_filter :find_next_school
        crudify :'refinery/registrations/registration',
                :title_attribute => 'surname', :xhr_paging => true,
                :order => "created_at DESC",
                :sortable => false

        def index
          @registrations = @school.registrations.order("created_at DESC").paginate(:page => params[:page])
        end

        protected

        def find_next_school
          @school = ::Refinery::Schools::School.last
        end
      end
    end
  end
end
