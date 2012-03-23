module Refinery
  module Links
    class LinksController < ::ApplicationController

      before_filter :find_all_links
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @link in the line below:
        present(@page)
      end

      def show
        @link = Link.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @link in the line below:
        present(@page)
      end

    protected

      def find_all_links
        @links = Link.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/links").first
      end

    end
  end
end
