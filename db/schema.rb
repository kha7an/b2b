# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_10_12_100811) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.text "terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "stock_availability", default: 0, null: false
    t.string "delivery_time"
    t.string "bonuses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_offers_on_product_id"
  end

  create_table "price_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pricing_rules", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "applicable_type"
    t.bigint "applicable_id"
    t.decimal "discount_percent", precision: 5, scale: 2
    t.decimal "markup_percent", precision: 5, scale: 2
    t.decimal "absolute_price", precision: 15, scale: 2
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicable_type", "applicable_id"], name: "index_pricing_rules_on_applicable_type_and_applicable_id"
    t.index ["client_id"], name: "index_pricing_rules_on_client_id"
  end

  create_table "product_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "sku", null: false
    t.string "brand"
    t.string "image_url"
    t.text "description"
    t.decimal "base_price", precision: 15, scale: 2, null: false
    t.bigint "product_group_id", null: false
    t.bigint "price_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_group_id"], name: "index_products_on_price_group_id"
    t.index ["product_group_id"], name: "index_products_on_product_group_id"
  end

  add_foreign_key "contracts", "clients"
  add_foreign_key "offers", "products"
  add_foreign_key "pricing_rules", "clients"
  add_foreign_key "products", "price_groups"
  add_foreign_key "products", "product_groups"
end
