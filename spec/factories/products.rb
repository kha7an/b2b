FactoryBot.define do
  factory :product do
    name { "Test Product" }
    sku { "SKU123" }
    brand { "Test Brand" }
    base_price { 1000 }
    association :product_group
    association :price_group
  end
end
