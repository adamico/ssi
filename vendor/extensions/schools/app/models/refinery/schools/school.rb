module Refinery
  module Schools
    class School < Refinery::Core::BaseModel
      self.table_name = 'refinery_schools'

      acts_as_indexed :fields => [:title, :place, :location, :extranight, :theme, :sub_theme, :organiser, :sub_organizer, :award, :intro_program, :publication, :state]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :vignlieu, :class_name => '::Refinery::Image'
      has_many :events, :class_name => '::Refinery::Events::Event'

      def short_title
        title.split(" ").first + " school"
      end

      def self.next
        with_state(:active).first
      end

      def self.imminent_or_next
        self.next || self.imminent
      end

      def self.imminent
        with_state(:imminent).last
      end

      def self.previous
        with_state(:closed)
      end

      def when_and_where
        if cancelled?
          "CANCELLED"
        elsif announced?
          month_and_year + " #{place}"
        else
          period + " (#{place})"
        end
      end

      def month_and_year
        "#{starts_at.strftime'%B'} #{starts_at.year}"
      end

      def period
        "#{starts_at.day}-#{ends_at.day} #{starts_at.strftime'%B'} #{starts_at.year}"
      end

      # state machines
      ### default state machine 'state'
      #TODO: add a cron task to close schools after deadline

      STATES = %w(draft announced imminent active closed cancelled)

      state_machine :initial => :draft do
        event :announce do
          transition :draft => :announced
        end
        event :prepare do
          transition :announced => :imminent
        end
        event :activate do
          transition :imminent => :active
        end
        event :close do
          transition :active => :closed
        end
        event :cancel do
          transition all - [:cancelled, :closed] => :cancelled
        end
      end

    end
  end
end
