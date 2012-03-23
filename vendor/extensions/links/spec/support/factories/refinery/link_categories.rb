
FactoryGirl.define do
  factory :link_category, :class => Refinery::LinkCategories::LinkCategory do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

