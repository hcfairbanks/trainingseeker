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

ActiveRecord::Schema.define(version: 20170312020335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "company_name"
    t.string   "email"
    t.string   "phone"
    t.string   "comment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "course_aliases", force: :cascade do |t|
    t.string   "course_alias"
    t.integer  "course_name_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "course_names", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "course_name_id"
    t.integer  "availability"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.string   "city"
    t.string   "province"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "postal_code"
    t.integer  "provider_id"
    t.string   "avatar"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "price_in_cents"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "pic"
    t.integer  "external_id"
    t.string   "external_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "provider_accounts", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "merchant_id"
    t.string   "api_key"
    t.integer  "discount_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["provider_id"], name: "index_provider_accounts_on_provider_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "city"
    t.string   "province_state"
    t.string   "postal_code"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "avatar"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "number_of_seats"
    t.float    "price"
    t.integer  "status"
    t.string   "response_id"
    t.text     "full_response"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "refund_response"
    t.index ["course_id"], name: "index_purchases_on_course_id", using: :btree
    t.index ["user_id"], name: "index_purchases_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seats", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "id_code"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "purchase_id"
    t.index ["purchase_id"], name: "index_seats_on_purchase_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "provider_id"
    t.string   "avatar"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "city"
    t.string   "province"
    t.date     "dob"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_approved",            default: false, null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["is_approved"], name: "index_users_on_is_approved", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "provider_accounts", "providers"
  add_foreign_key "purchases", "courses"
  add_foreign_key "purchases", "users"
  add_foreign_key "seats", "purchases"
end
