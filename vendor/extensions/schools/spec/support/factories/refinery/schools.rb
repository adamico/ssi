
FactoryGirl.define do
  factory :school, :class => Refinery::Schools::School do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

