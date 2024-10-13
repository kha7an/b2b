class ProductGroup < ApplicationRecord
  has_many :products
  has_many :pricing_rules, as: :applicable

  validates :name, presence: true
end
