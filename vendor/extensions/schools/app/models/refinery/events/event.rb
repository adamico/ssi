module Refinery
  module Events
    class Event < Refinery::Core::BaseModel
      self.table_name = 'refinery_events'

      acts_as_indexed :fields => [:title, :speaker]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :school, :class_name => '::Refinery::Schools::School'
    end
  end
end
