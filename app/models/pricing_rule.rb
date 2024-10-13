class PricingRule < ApplicationRecord
  belongs_to :client
  belongs_to :applicable, polymorphic: true, optional: true

  validates :client, presence: true
  validates :priority, presence: true

  validate :validate_pricing_parameters

  def invalidate_cache
    Redis.current.del("client_#{client.id}_offers_*_prices")
  end

  private

  def validate_pricing_parameters
    if [discount_percent, markup_percent, absolute_price].compact.size != 1
      errors.add(:base, "Должен быть указан только один из параметров: скидка, наценка или абсолютная цена")
    end
  end
end
