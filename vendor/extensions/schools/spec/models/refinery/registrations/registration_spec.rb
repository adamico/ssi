require 'spec_helper'

module Refinery
  module Registrations
    describe Registration do
      describe "validations" do
        subject do
          FactoryGirl.create(:registration,
          :surname => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:surname) { should == "Refinery CMS" }
      end
    end
  end
end
