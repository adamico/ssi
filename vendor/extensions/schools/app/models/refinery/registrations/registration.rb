# encoding: UTF-8
module Refinery
  module Registrations
    class Registration < Refinery::Core::BaseModel
      self.table_name = 'refinery_registrations'

      acts_as_indexed :fields => [:surname, :first_name, :title, :company, :address, :city, :zip, :country, :phone, :fax, :email, :accompagne, :ip, :payment, :amount, :payment_date, :state]
      include Humanizer
      attr_accessor :bypass_humanizer
      attr_accessible :humanizer_answer, :humanizer_question_id, :surname, :first_name, :title, :company, :address, :city, :zip, :country, :phone, :fax, :email, :vegetarian, :muslim, :kosher, :dietary_other, :dietary_what, :accompagne_title, :accompagne_last_name, :accompagne_first_name, :accompagne_country, :accompagne_vegetarian, :accompagne_muslim, :accompagne_kosher, :accompagne_dietary_other, :accompagne_dietary_what, :accompagne, :ip, :payment, :amount, :payment_date, :state, :school_id, :arrival, :departure, :state_event, :accompanying_amount

      if Rails.env.production?
        require_human_on :create, :unless => :bypass_humanizer
      end

      validates :surname, presence: true
      validates :company, presence: true
      validates :phone, presence: true
      validates :email, presence: true

      belongs_to :school, :class_name => '::Refinery::Schools::School'

      def formatted_amount
       (amount / 100).to_s + " €"
      end

      def title_with_name
        [self.try(:title), first_name, surname].join(" ")
      end

      def dietary_requests(prefix="")
        result = []
        %w(vegetarian muslim kosher).each do |field|
          result << field.to_s if self.send(:"#{prefix}#{field}")
        end
        result << self.send(:"#{prefix}dietary_what") if self.send(:"#{prefix}dietary_other")
        result.any? ? result.compact.join(", ") : "none"
      end


      PAYMENT_METHODS = [["Bank Transfer", :bank], ["Check", :check], ["Credit Card", :online]]

      STATES = %w(pending payed refunded)

      state_machine :initial => :pending do
        event :accept do
          transition :pending => :payed
        end
        event :refund do
          transition :payed => :refunded
        end
      end

      def update_payment_date(date)
        update_attributes(payment_date: date)
      end
    end
  end
end
