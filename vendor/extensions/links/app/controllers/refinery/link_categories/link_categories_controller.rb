module Refinery
  module LinkCategories
    class LinkCategoriesController < ::ApplicationController
      def index
        @link_categories = LinkCategory.order('position ASC')
        @other_links = ::Refinery::Links::Link.uncategorized
        @page = ::Refinery::Page.where(:link_url => "/link_categories").first
      end
    end
  end
end
