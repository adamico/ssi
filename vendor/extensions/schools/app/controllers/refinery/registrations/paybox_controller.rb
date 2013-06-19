module Refinery
  module Registrations
    class PayboxController < ::ApplicationController
      include Paybox::System::Rails::Integrity
      before_filter :find_registration
      #before_filter :check_paybox_integrity!

      def ipn
        if params[:error] == "00000"
          logger.info "Successful Transaction : #{params.inspect}"
        end
        render text: "OK"
      end

      def canceled
        @page = ::Refinery::Page.where(link_url: "/payment_canceled").first
      end

      def refused
        @page = ::Refinery::Page.where(link_url: "/payment_refused").first
      end

      def accepted
        @registration.accept!
        @registration.update_payment_date(params[:date] + params[:heure])
        @page = ::Refinery::Page.where(link_url: "/payment_accepted").first
      end

      protected

      def find_registration
        @registration = Registration.find(params[:registration])
      end

    end
  end
end
