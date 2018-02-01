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

ActiveRecord::Schema.define(version: 20171229082905) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_order"
  end

  create_table "customers", force: :cascade do |t|
    t.string "formOfAddress"
    t.string "firstname"
    t.string "lastname"
    t.string "streetname"
    t.string "addressAdditive"
    t.integer "plz"
    t.string "city"
    t.string "email"
    t.string "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "propertyItem_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
    t.index ["propertyItem_id"], name: "index_line_items_on_propertyItem_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.string "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "payment_id"
    t.integer "shipment_id"
    t.string "state"
    t.datetime "pay_day"
    t.datetime "delivery_date"
    t.string "distribution_number"
    t.datetime "warning"
    t.text "notes"
    t.string "status"
    t.string "p_paymentMethod"
    t.string "p_acceptance"
    t.integer "p_status"
    t.text "p_payid"
    t.string "p_brand"
    t.decimal "total_amount"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.decimal "costs", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "short_name"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "product_nr"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "promotionPrice", precision: 8, scale: 2
    t.date "promotionStartDate"
    t.date "promotionEndDate"
    t.boolean "isActivate", default: true
    t.integer "inStock"
    t.date "sale_start_date"
    t.date "sale_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_id"
    t.string "slug"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "property_id"
    t.index ["property_id"], name: "index_products_on_property_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "order"
    t.integer "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["property_id"], name: "index_property_items_on_property_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "name"
    t.decimal "costs", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_token"
    t.boolean "admin"
    t.string "state"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "website_settings", force: :cascade do |t|
    t.string "mailAddress"
    t.date "webstoreOpen"
    t.date "webstoreClose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
