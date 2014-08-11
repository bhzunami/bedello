# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140808080310) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_order"
  end

  create_table "customers", force: true do |t|
    t.string   "formOfAddress"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "streetname"
    t.string   "addressAdditive"
    t.integer  "plz"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "propertyItem_id"
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"
  add_index "line_items", ["propertyItem_id"], name: "index_line_items_on_propertyItem_id"

  create_table "orders", force: true do |t|
    t.integer  "customer_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_id"
    t.integer  "shipment_id"
    t.string   "state"
    t.datetime "pay_day"
    t.datetime "delivery_date"
    t.string   "distribution_number"
    t.datetime "warning"
    t.text     "notes"
    t.string   "status"
  end

  create_table "payments", force: true do |t|
    t.string   "name"
    t.decimal  "costs",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "productNr"
    t.decimal  "price",              precision: 8, scale: 2
    t.decimal  "promotionPrice",     precision: 8, scale: 2
    t.date     "promotionStartDate"
    t.date     "promotionEndDate"
    t.boolean  "isActivate",                                 default: true
    t.integer  "inStock"
    t.date     "sale_start_date"
    t.date     "sale_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "property_id"
  end

  add_index "products", ["property_id"], name: "index_products_on_property_id"
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true

  create_table "properties", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "order"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "property_items", ["property_id"], name: "index_property_items_on_property_id"

  create_table "shipments", force: true do |t|
    t.string   "name"
    t.decimal  "costs",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "state"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "website_settings", force: true do |t|
    t.string   "mailAddress"
    t.date     "webstoreOpen"
    t.date     "webstoreClose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
