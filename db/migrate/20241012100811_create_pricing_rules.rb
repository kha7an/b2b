class CreatePricingRules < ActiveRecord::Migration[7.1]
  def change
    create_table :pricing_rules do |t|
      t.references :client, null: false, foreign_key: true

      # Полиморфная ассоциация для объекта, к которому применяется правило
      t.string :applicable_type
      t.bigint :applicable_id
      t.index [:applicable_type, :applicable_id]

      # Параметры правила ценообразования
      t.decimal :discount_percent, precision: 5, scale: 2
      t.decimal :markup_percent, precision: 5, scale: 2
      t.decimal :absolute_price, precision: 15, scale: 2
      t.integer :priority
      t.timestamps
    end

  end
end
