# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170707014147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "mobile"
    t.string "receiver"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mobile_valid", default: false
  end

  create_table "assets", force: :cascade do |t|
    t.integer "viewable_id"
    t.string "viewable_type"
    t.string "attachment"
    t.integer "position"
    t.string "alt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["viewable_id"], name: "index_assets_on_viewable_id"
    t.index ["viewable_type"], name: "index_assets_on_viewable_type"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["rgt"], name: "index_categories_on_rgt"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "order_id"
    t.integer "quantity", default: 0
    t.decimal "price", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["variant_id"], name: "index_line_items_on_variant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "number"
    t.decimal "item_total", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "total", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "item_count", default: 0, null: false
    t.string "state"
    t.integer "user_id", null: false
    t.integer "refunded_by"
    t.integer "ship_address_id"
    t.datetime "completed_at"
    t.datetime "canceled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "shipment_required", default: true
    t.index ["number"], name: "index_orders_on_number"
    t.index ["state"], name: "index_orders_on_state"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.json "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false
    t.index ["id", "type"], name: "index_payment_methods_on_id_and_type"
  end

  create_table "payments", force: :cascade do |t|
    t.string "number"
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "order_id"
    t.integer "payment_method_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_payments_on_number"
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "available", default: true
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["description"], name: "index_products_on_description"
    t.index ["name"], name: "index_products_on_name"
  end

  create_table "refunds", force: :cascade do |t|
    t.string "number"
    t.integer "payment_id"
    t.decimal "amount", precision: 12, scale: 2, default: "0.0", null: false
    t.string "description"
    t.integer "operator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_refunds_on_number"
  end

  create_table "stock_changes", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "quantity", default: 0, null: false
    t.integer "source_id"
    t.string "source_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id", "source_type"], name: "index_stock_changes_on_source_id_and_source_type"
    t.index ["variant_id"], name: "index_stock_changes_on_variant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "login"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "avatar"
    t.string "name"
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 12, scale: 2
    t.bigint "product_id"
    t.string "sku", default: "", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_variants_on_name"
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["sku"], name: "index_variants_on_sku"
  end

end
