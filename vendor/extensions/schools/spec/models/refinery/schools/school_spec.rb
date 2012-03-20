require 'spec_helper'

module Refinery
  module Schools
    describe School do
      subject do
        FactoryGirl.create(:school,
        :title => "Refinery CMS")
      end
      describe "validations" do
        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
      describe ".previous" do
        it "should return schools with state :closed" do
          school = FactoryGirl.create(:school, state: "closed")
          School.previous.should == [school]
        end
      end
      describe "#when_and_where" do
        before do
          subject.starts_at = Time.now.to_date
          subject.ends_at = Time.now.to_date + 1.day
          subject.place = "Lyon"
        end
        context "when school is cancelled" do
          it "should return 'CANCELLED'" do
            subject.state = "cancelled"
            subject.when_and_where.should == "CANCELLED"
          end
        end
        context "when school is announced" do
          it "should return 'Month + year + place" do
            subject.state = "announced"
            subject.when_and_where.should == "March 2012 Lyon"
          end
        end
        it "should return exact period and (place)" do
          subject.state = "active"
          subject.when_and_where.should == "19-20 March 2012 (Lyon)"
        end
      end
    end
  end
end
