class Contract < ApplicationRecord
  belongs_to :client
  has_many :pricing_rules, as: :applicable

  validates :client, presence: true
end
