class Client < ApplicationRecord
  has_many :contracts
  has_many :pricing_rules

  validates :name, presence: true
end
