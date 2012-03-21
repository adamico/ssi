
FactoryGirl.define do
  factory :registration, :class => Refinery::Registrations::Registration do
    sequence(:surname) { |n| "refinery#{n}" }
  end
end

