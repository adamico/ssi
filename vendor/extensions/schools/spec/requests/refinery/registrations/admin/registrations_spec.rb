# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Registrations" do
    describe "Admin" do
      describe "registrations" do
        login_refinery_user

        describe "registrations list" do
          before(:each) do
            FactoryGirl.create(:registration, :surname => "UniqueTitleOne")
            FactoryGirl.create(:registration, :surname => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.registrations_admin_registrations_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.registrations_admin_registrations_path

            click_link "Add New Registration"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Surname", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Registrations::Registration.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Surname can't be blank")
              Refinery::Registrations::Registration.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:registration, :surname => "UniqueTitle") }

            it "should fail" do
              visit refinery.registrations_admin_registrations_path

              click_link "Add New Registration"

              fill_in "Surname", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Registrations::Registration.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:registration, :surname => "A surname") }

          it "should succeed" do
            visit refinery.registrations_admin_registrations_path

            within ".actions" do
              click_link "Edit this registration"
            end

            fill_in "Surname", :with => "A different surname"
            click_button "Save"

            page.should have_content("'A different surname' was successfully updated.")
            page.should have_no_content("A surname")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:registration, :surname => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.registrations_admin_registrations_path

            click_link "Remove this registration forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Registrations::Registration.count.should == 0
          end
        end

      end
    end
  end
end
