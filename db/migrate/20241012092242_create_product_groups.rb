class CreateProductGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :product_groups do |t|
      t.string :name, null: false

      t.timestamps

    end
  end
end
