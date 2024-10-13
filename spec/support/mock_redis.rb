RSpec.configure do |config|
  config.before(:each) do
    $redis = MockRedis.new
  end
end
RSpec.describe Offer, type: :model do
  let(:client) { create(:client) }
  let(:product) { create(:product, base_price: 1000) }
  let(:offer) { create(:offer, product: product) }

  context 'кэшируется' do
    it 'поиск цены из кэша' do
      cache_key = "client_#{client.id}_offers_#{offer.id}_prices"
      $redis.set(cache_key, [{ offer: offer, price: 900 }].to_json)

      final_price = Offer.calculate_prices([offer], client)
      expect(final_price.first[:price]).to eq(900) # Данные взяты из кэша
    end
  end

  context 'без кэша' do
    it 'сохранение в кэше' do
      final_price = Offer.calculate_prices([offer], client)
      cache_key = "client_#{client.id}_offers_#{offer.id}_prices"

      expect($redis.get(cache_key)).not_to be_nil
      expect(final_price.first[:price]).to eq(1000) # Нет скидки, базовая цена
    end
  end
end
