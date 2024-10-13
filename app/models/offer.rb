class Offer < ApplicationRecord
  belongs_to :product

  validates :product, presence: true
  validates :stock_availability, numericality: { greater_than_or_equal_to: 0 }


  def self.calculate_prices(offers, client)
    # Генерация уникального ключа для кэша
    cache_key = "client_#{client.id}_offers_#{offers.map(&:id).join('_')}_prices"

    # Проверяем, есть ли результат в кэше
    cached_prices = $redis.get(cache_key)
    return JSON.parse(cached_prices) if cached_prices.present?

    # Если кэша нет, производим расчет
    calculated_prices = offers.map do |offer|
      base_price = offer.product.base_price
      applicable_rule = find_applicable_rule(offer.product, client)
      final_price = apply_pricing_rule(base_price, applicable_rule)
      { offer: offer, price: final_price }
    end

    # Сохраняем результат в кэш на 1 час
    $redis.set(cache_key, calculated_prices.to_json, ex: 1.hour)

    calculated_prices
  end


  def self.find_applicable_rule(product, client)#цена с наисвысшим приорететом
    PricingRule.where(client: client)
               .where(applicable: [product, product.price_group, product.product_group, client.contracts])
               .order(priority: :desc)
               .first
  end


  def self.apply_pricing_rule(base_price, rule)#правила цены
    return base_price unless rule

    if rule.discount_percent.present?
      apply_discount(base_price, rule.discount_percent)
    elsif rule.markup_percent.present?
      apply_markup(base_price, rule.markup_percent)
    elsif rule.absolute_price.present?
      rule.absolute_price
    else
      base_price
    end
  end

  def self.apply_discount(base_price, discount_percent)
    base_price - (base_price * discount_percent / 100)
  end

  def self.apply_markup(base_price, markup_percent)
    base_price + (base_price * markup_percent / 100)
  end
end
