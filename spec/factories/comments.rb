# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    description { 'MyText' }
    post { nil }
    user { nil }
  end
end
