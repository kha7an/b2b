FactoryBot.define do
  factory :pricing_rule do
    client
    applicable { nil }
    priority { 1 }

    trait :with_discount do
      discount_percent { 10 }
    end

    trait :with_absolute_price do
      absolute_price { 800 }
    end
  end
end
