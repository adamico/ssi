module Refinery
  module Links
    module Admin
      class LinksController < ::Refinery::AdminController

        crudify :'refinery/links/link', :xhr_paging => true

      end
    end
  end
end
