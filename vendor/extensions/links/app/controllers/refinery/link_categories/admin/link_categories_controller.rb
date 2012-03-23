module Refinery
  module LinkCategories
    module Admin
      class LinkCategoriesController < ::Refinery::AdminController

        crudify :'refinery/link_categories/link_category', :xhr_paging => true

      end
    end
  end
end
