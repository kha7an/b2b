FactoryBot.define do
  factory :offer do
    stock_availability { 10 }
    association :product
  end
end
