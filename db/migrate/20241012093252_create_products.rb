class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string  :name,         null: false
      t.string  :sku,          null: false
      t.string  :brand
      t.string  :image_url
      t.text    :description
      t.decimal :base_price,   precision: 15, scale: 2, null: false

      t.references :product_group, null: false, foreign_key: true
      t.references :price_group,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
