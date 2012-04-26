module Refinery
  module Registrations
    class RegistrationsController < ::ApplicationController
      before_filter :find_next_school
      before_filter :find_page

      def new
        @registration = ::Refinery::Registrations::Registration.new(school_id: @school.id) if @school
      end

      def create
        @registration = ::Refinery::Registrations::Registration.new(params[:registration])
        @registration.ip = request.remote_ip
        @registration.amount = @school.price

        if @registration.save
          success
        else
          render :new
        end
      end

      def edit
        @registration = ::Refinery::Registrations::Registration.find(params[:id])
      end

      def update
        @registration = ::Refinery::Registrations::Registration.find(params[:id])
        @registration.amount = @school.price
        if @registration.update_attributes(params[:registration])
          success
        else
          render :edit
        end
      end

      protected

      def find_next_school
        @school = ::Refinery::Schools::School.try(:imminent_or_next)
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/registration").first
      end

      def success
        RegistrationMailer.registration_confirmation(@registration).deliver
        RegistrationMailer.registration_log(@registration).deliver
        @page = ::Refinery::Page.where(link_url: "/thank_you").first
        render 'thank_you'
      end
    end
  end
end
