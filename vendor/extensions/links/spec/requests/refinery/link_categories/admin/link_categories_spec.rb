# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "LinkCategories" do
    describe "Admin" do
      describe "link_categories" do
        login_refinery_user

        describe "link_categories list" do
          before(:each) do
            FactoryGirl.create(:link_category, :title => "UniqueTitleOne")
            FactoryGirl.create(:link_category, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.link_categories_admin_link_categories_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.link_categories_admin_link_categories_path

            click_link "Add New Link Category"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::LinkCategories::LinkCategory.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::LinkCategories::LinkCategory.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:link_category, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.link_categories_admin_link_categories_path

              click_link "Add New Link Category"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::LinkCategories::LinkCategory.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:link_category, :title => "A title") }

          it "should succeed" do
            visit refinery.link_categories_admin_link_categories_path

            within ".actions" do
              click_link "Edit this link category"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:link_category, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.link_categories_admin_link_categories_path

            click_link "Remove this link category forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::LinkCategories::LinkCategory.count.should == 0
          end
        end

      end
    end
  end
end
