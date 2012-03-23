module Refinery
  module LinkCategories
    class LinkCategoriesController < ::ApplicationController

      before_filter :find_all_link_categories
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @link_category in the line below:
        present(@page)
      end

      def show
        @link_category = LinkCategory.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @link_category in the line below:
        present(@page)
      end

    protected

      def find_all_link_categories
        @link_categories = LinkCategory.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/link_categories").first
      end

    end
  end
end
