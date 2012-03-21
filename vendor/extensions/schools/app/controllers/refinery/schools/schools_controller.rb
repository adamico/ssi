module Refinery
  module Schools
    class SchoolsController < ::ApplicationController

      before_filter :find_all_schools
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @school in the line below:
        present(@page)
      end

      def show
        @school = School.imminent_or_next
        events = @school.events
        @events_days = events.group_by { |event| event.starts_at.beginning_of_day }

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @school in the line below:
        present(@page)
      end

    protected

      def find_all_schools
        @schools = School.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/schools").first
      end

    end
  end
end
