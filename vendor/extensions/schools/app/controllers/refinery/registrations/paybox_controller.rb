module Refinery
  module Registrations
    class PayboxController < ::ApplicationController
      include Paybox::System::Rails::Integrity
      before_filter :find_registration
      before_filter :check_paybox_integrity!

      def ipn
        if params[:error] == "00000"
          logger.info "Successful Transaction : #{params.inspect}"
          @registration.update_attribute(:status, "accepted")
          logger.info "Updating registration #{@registration.id} status to 'accepted'"
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
        @page = ::Refinery::Page.where(link_url: "/payment_accepted").first
      end

      protected

      def find_registration
        @registration = Registration.find(params[:registration])
      end

    end
  end
end
