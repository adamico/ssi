# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Schools" do
    describe "Admin" do
      describe "schools" do
        login_refinery_user

        describe "schools list" do
          before(:each) do
            FactoryGirl.create(:school, :title => "UniqueTitleOne")
            FactoryGirl.create(:school, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.schools_admin_schools_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.schools_admin_schools_path

            click_link "Add New School"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Schools::School.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Schools::School.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:school, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.schools_admin_schools_path

              click_link "Add New School"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Schools::School.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:school, :title => "A title") }

          it "should succeed" do
            visit refinery.schools_admin_schools_path

            within ".actions" do
              click_link "Edit this school"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:school, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.schools_admin_schools_path

            click_link "Remove this school forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Schools::School.count.should == 0
          end
        end

      end
    end
  end
end
