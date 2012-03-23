
FactoryGirl.define do
  factory :link, :class => Refinery::Links::Link do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

