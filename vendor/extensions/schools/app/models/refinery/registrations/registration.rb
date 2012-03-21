# encoding: UTF-8
module Refinery
  module Registrations
    class Registration < Refinery::Core::BaseModel
      self.table_name = 'refinery_registrations'

      acts_as_indexed :fields => [:surname, :first_name, :title, :company, :address, :city, :zip, :country, :phone, :fax, :email, :accompagne, :ip, :payment, :amount, :payment_date, :state]

      validates :surname, :presence => true
      validates :arrival, :presence => true
      validates :departure, :presence => true

      belongs_to :school, :class_name => '::Refinery::Schools::School'

      def formatted_amount
       (amount / 100).to_s + " €"
      end

      def title_with_name
        [self.try(:title), first_name, surname].join(" ")
      end
    end
  end
end
