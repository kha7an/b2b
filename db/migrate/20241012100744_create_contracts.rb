class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.text       :terms
      t.timestamps
    end
  end
end
