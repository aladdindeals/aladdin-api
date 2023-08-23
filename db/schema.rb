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

ActiveRecord::Schema[7.0].define(version: 2023_08_23_022845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "ltree"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "affiliate_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id"
    t.jsonb "configurations", default: {}
    t.jsonb "scrapping_configuration", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_affiliate_settings_on_partner_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id"
    t.string "name"
    t.string "source_name"
    t.ltree "parent_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_categories_on_partner_id"
  end

  create_table "partners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "domain", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_partners_on_name", unique: true
  end

  create_table "product_specifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.string "group", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "name", "group"], name: "index_product_specifications_on_product_id_and_name_and_group", unique: true
    t.index ["product_id"], name: "index_product_specifications_on_product_id"
  end

  create_table "product_url_mappings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_url_id"
    t.uuid "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_url_mappings_on_product_id"
    t.index ["product_url_id"], name: "index_product_url_mappings_on_product_url_id"
  end

  create_table "product_urls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "url", null: false
    t.uuid "partner_id"
    t.integer "scraping_status", default: 0
    t.datetime "scraping_started_on"
    t.datetime "scraping_ended_on"
    t.integer "url_source", default: 0
    t.string "channel_name"
    t.text "failure_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_product_urls_on_partner_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id"
    t.uuid "category_id"
    t.string "pid", null: false
    t.text "name", null: false
    t.text "description", null: false
    t.bigint "total_ratings", default: 0
    t.bigint "total_reviews", default: 0
    t.float "avg_rating", default: 0.0
    t.float "price", default: 0.0
    t.float "maximum_retail_price", default: 0.0
    t.float "offer_percentage", default: 0.0
    t.jsonb "meta_headers", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["partner_id"], name: "index_products_on_partner_id"
    t.index ["pid", "partner_id", "category_id"], name: "index_products_on_pid_and_partner_id_and_category_id", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "phone_number", null: false
    t.string "encrypted_password", null: false
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "affiliate_settings", "partners"
  add_foreign_key "categories", "partners"
  add_foreign_key "product_specifications", "products"
  add_foreign_key "product_url_mappings", "product_urls"
  add_foreign_key "product_url_mappings", "products"
  add_foreign_key "product_urls", "partners"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "partners"
end
