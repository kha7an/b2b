class Product < ApplicationRecord
  belongs_to :product_group
  belongs_to :price_group
  has_many :offers
  has_many :pricing_rules, as: :applicable

  validates :name, :sku, :base_price, :product_group, :price_group, presence: true
  validates :sku, uniqueness: true
  validates :base_price, numericality: { greater_than_or_equal_to: 0 }
end
