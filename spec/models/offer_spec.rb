require 'rails_helper'

RSpec.describe Offer, type: :model do
  let(:client) { create(:client) }
  let(:product) { create(:product, base_price: 1000) }
  let(:offer) { create(:offer, product: product) }

  context 'с ценообразованием' do
    let!(:pricing_rule) { create(:pricing_rule, client: client, applicable: product, discount_percent: 10) }

    it 'со скидкой' do
      final_price = Offer.calculate_prices([offer], client)
      expect(final_price.first[:price]).to eq(900) # 10% скидка от 1000
    end
  end

  context 'без скидки' do
    it 'без ценообразования' do
      other_client = create(:client)
      final_price = Offer.calculate_prices([offer], other_client)
      expect(final_price.first[:price]).to eq(1000) # Цена без скидки
    end
  end

  context 'абсотютная цена' do
    let!(:pricing_rule) { create(:pricing_rule, :with_absolute_price, client: client, applicable: product) }

    it 'с абсолютной ценой' do
      final_price = Offer.calculate_prices([offer], client)
      expect(final_price.first[:price]).to eq(800) # Абсолютная цена 800
    end
  end
end
