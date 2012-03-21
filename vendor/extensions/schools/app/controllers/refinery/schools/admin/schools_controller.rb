module Refinery
  module Schools
    module Admin
      class SchoolsController < ::Refinery::AdminController
        before_filter :find_next_school

        crudify :'refinery/schools/school', :xhr_paging => true,
                :sortable => false, :order => "starts_at DESC"

        protected

        def find_next_school
          @next_school = ::Refinery::Schools::School.last
        end
      end
    end
  end
end
