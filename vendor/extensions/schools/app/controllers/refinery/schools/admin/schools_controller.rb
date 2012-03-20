module Refinery
  module Schools
    module Admin
      class SchoolsController < ::Refinery::AdminController

        crudify :'refinery/schools/school', :xhr_paging => true

      end
    end
  end
end
