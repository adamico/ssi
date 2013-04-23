# encoding: UTF-8
module Refinery
  module Schools
    class School < Refinery::Core::BaseModel
      self.table_name = 'refinery_schools'
      attr_accessible :title, :starts_at, :ends_at, :place, :location, :vignlieu_id, :price, :early_bird_price, :accompagne_price, :early_bird_date, :deadline, :extranight, :theme, :sub_theme, :organiser, :sub_organizer, :award, :intro_program, :publication, :state, :position, :latitude, :longitude, :gmaps, :registrations_start_at, :intro_registration

      acts_as_indexed :fields => [:title, :place, :location, :extranight, :theme, :sub_theme, :organiser, :sub_organizer, :award, :intro_program, :publication, :state]

      validates :title, :presence => true, :uniqueness => true

      belongs_to :vignlieu, :class_name => '::Refinery::Image'
      has_many :events, :class_name => '::Refinery::Events::Event'
      has_many :registrations, :class_name => '::Refinery::Registrations::Registration'
      geocoded_by :location
      after_validation :geocode, :if => :location_changed?

      def short_title
        title.split(" ").first + " school"
      end

      self.per_page = 5

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

      def total_price
        current_price + accompagne_price
      end

      def current_price
        Date.today <= early_bird_date ? early_bird_price : price
      end

      def price_without_vat(the_price)
        (the_price / 100 / 1.196).round(2)
      end

      def formatted_price(price_method)
        (self.send(price_method) / 100).to_s + " €"
      end

      def when_and_where
        if cancelled?
          "CANCELED"
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
        if starts_at.month == ends_at.month
          "#{starts_at.day}-#{ends_at.day} #{starts_at.strftime'%B'} #{starts_at.year}"
        else
          "#{starts_at.day} #{starts_at.strftime'%B'} - #{ends_at.day} #{ends_at.strftime'%B'} #{starts_at.year}"
        end
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
