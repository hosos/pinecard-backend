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

ActiveRecord::Schema.define(version: 2021_01_04_151124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "category", default: 0
    t.string "value"
    t.bigint "my_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_card_id"], name: "index_addresses_on_my_card_id"
  end

  create_table "contact_requests", force: :cascade do |t|
    t.integer "status", default: 0
    t.text "message"
    t.bigint "owner_card_id", null: false
    t.bigint "friend_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friend_card_id"], name: "index_contact_requests_on_friend_card_id"
    t.index ["owner_card_id"], name: "index_contact_requests_on_owner_card_id"
  end

  create_table "emails", force: :cascade do |t|
    t.integer "category", default: 0
    t.string "value"
    t.bigint "my_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_card_id"], name: "index_emails_on_my_card_id"
  end

  create_table "hash_tags", force: :cascade do |t|
    t.string "value"
    t.string "holder_type", null: false
    t.bigint "holder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["holder_type", "holder_id"], name: "index_hash_tags_on_holder"
  end

  create_table "my_cards", force: :cascade do |t|
    t.integer "name_prefix"
    t.string "fullname"
    t.text "description"
    t.string "organization"
    t.string "title"
    t.string "role"
    t.integer "gender"
    t.date "birthday"
    t.integer "daily_send_request_quota", default: 10
    t.integer "daily_receive_request_quota", default: 10
    t.integer "category", default: 0
    t.bigint "user_id", null: false
    t.boolean "public", default: false
    t.boolean "primary", default: false
    t.boolean "auto_accept_request", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_my_cards_on_user_id"
  end

  create_table "phones", force: :cascade do |t|
    t.integer "category", default: 0
    t.string "value"
    t.bigint "my_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_card_id"], name: "index_phones_on_my_card_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "category", default: "photo"
    t.string "holder_type", null: false
    t.bigint "holder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_photos_on_category"
    t.index ["holder_type", "holder_id"], name: "index_photos_on_holder"
  end

  create_table "social_urls", force: :cascade do |t|
    t.integer "category", default: 0
    t.string "value"
    t.bigint "my_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_card_id"], name: "index_social_urls_on_my_card_id"
  end

  create_table "telegram_accounts", force: :cascade do |t|
    t.string "telegram_id"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "photo_url"
    t.integer "my_card_quota", default: 20
    t.integer "contact_quota", default: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_telegram_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "website_urls", force: :cascade do |t|
    t.integer "category", default: 0
    t.string "value"
    t.bigint "my_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_card_id"], name: "index_website_urls_on_my_card_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "my_cards"
  add_foreign_key "contact_requests", "my_cards", column: "friend_card_id"
  add_foreign_key "contact_requests", "my_cards", column: "owner_card_id"
  add_foreign_key "emails", "my_cards"
  add_foreign_key "my_cards", "users"
  add_foreign_key "phones", "my_cards"
  add_foreign_key "social_urls", "my_cards"
  add_foreign_key "telegram_accounts", "users"
  add_foreign_key "website_urls", "my_cards"
end
