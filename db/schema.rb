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

ActiveRecord::Schema.define(version: 2019_05_21_120437) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assetclasses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "assetclass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.integer "followed_id"
    t.string "followed_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_messages", force: :cascade do |t|
    t.text "content"
    t.string "name"
    t.string "email"
    t.text "contacts"
    t.string "firm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_messages", force: :cascade do |t|
    t.text "subject"
    t.text "text_message"
    t.integer "product_id"
    t.integer "receiver_id"
    t.integer "senter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "email_message_id"
    t.integer "status", default: 0
    t.boolean "confidential", default: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "content"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "firms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "whatsapp"
    t.string "skype"
    t.string "linkedin"
    t.string "facebook"
    t.string "instagram"
    t.string "firm_phone"
    t.string "cnpj"
    t.string "website"
    t.string "address"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "notification_type"
    t.integer "check_status", default: 0
    t.integer "answer_status", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.integer "postable_id"
    t.string "postable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "assetclass_id"
    t.integer "article_type"
    t.integer "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "management_firm"
    t.string "destribuitor"
    t.string "inception_date"
    t.integer "assetclass_id"
    t.integer "category_id"
    t.integer "firm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "other_obs"
    t.integer "target_return_benchmark_from"
    t.integer "target_return_benchmark_to"
    t.integer "view_status", default: 0
    t.datetime "from_investment_period"
    t.datetime "to_investment_period"
    t.string "street_name"
    t.string "street_number"
    t.integer "zip_code"
    t.string "city"
    t.string "room_number"
    t.string "neighborhood"
    t.integer "english_level"
    t.integer "spanish_level"
    t.integer "educational_level"
    t.string "skill_tags", default: [], array: true
    t.integer "age"
    t.integer "user_id"
    t.text "requirement"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "street_name"
    t.string "street_number"
    t.integer "zip_code"
    t.string "city"
    t.string "room_number"
    t.integer "english_level"
    t.integer "spanish_level"
    t.integer "educational_level"
    t.text "short_profile"
    t.string "skill_tags", default: [], array: true
    t.integer "age"
    t.text "long_profile"
    t.string "neighborhood"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotations", force: :cascade do |t|
    t.integer "senter_id"
    t.integer "receiver_id"
    t.string "quote"
    t.text "senter_message"
    t.text "receiver_message"
    t.integer "firm_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_id"
    t.integer "status", default: 0
    t.integer "product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.text "description"
    t.bigint "whatsapp"
    t.string "skype"
    t.string "linkedin"
    t.string "facebook"
    t.string "instagram"
    t.string "firm_phone"
    t.string "official_registration"
    t.string "website"
    t.string "avatar"
    t.boolean "admin", default: false
    t.string "address"
    t.integer "firm_id"
    t.string "job_title"
    t.integer "zip_code"
    t.string "segmentation", default: [], array: true
    t.boolean "approved", default: false, null: false
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.integer "videoable_id"
    t.string "videoable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
