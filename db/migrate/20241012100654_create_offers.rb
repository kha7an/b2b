class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :product,           null: false, foreign_key: true
      t.integer    :stock_availability, default: 0, null: false
      t.string     :delivery_time
      t.string     :bonuses
      t.timestamps
    end
  end
end
