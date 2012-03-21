module Refinery
  module Events
    class Event < Refinery::Core::BaseModel
      self.table_name = 'refinery_events'

      acts_as_indexed :fields => [:title, :speaker]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :school, :class_name => '::Refinery::Schools::School'

      def day_month
        self.starts_at.strftime("%e/%m")
      end
      def time
        self.starts_at.strftime("%R")
      end
    end
  end
end
