module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :find_next_school, :last_event_time
        crudify :'refinery/events/event', :xhr_paging => true,
                :order => "starts_at DESC",
                :sortable => false

        def new
          @event = ::Refinery::Events::Event.new(:school_id => @school.id)
        end

        protected

        def find_next_school
          @school = ::Refinery::Schools::School.last
        end

        def last_event_time
          @last_event_time = @school.events.last.starts_at + 45.minutes rescue Time.now
        end
      end
    end
  end
end
