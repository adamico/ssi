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
        @school = School.last
        if @school
          events = @school.events.order(:starts_at)
          @events_days = events.group_by { |event| event.starts_at.beginning_of_day }

          respond_to do |format|
            format.html do
              present(@page)
            end
            format.pdf do
              pdf = SchoolPdf.new(@school, view_context, @events_days)
              send_data pdf.render, filename: "#{@school.short_title}_program.pdf",
                type: "application/pdf",
                disposition: "inline"
            end
          end
        end
      end

    protected

      def find_all_schools
        @schools = School.page(params[:page]).order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/schools").first
      end

    end
  end
end
