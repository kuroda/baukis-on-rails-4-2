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

ActiveRecord::Schema.define(version: 20160102091921) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "customer_id",   limit: 4,                null: false
    t.string   "type",          limit: 255,              null: false
    t.string   "postal_code",   limit: 255,              null: false
    t.string   "prefecture",    limit: 255,              null: false
    t.string   "city",          limit: 255,              null: false
    t.string   "address1",      limit: 255,              null: false
    t.string   "address2",      limit: 255,              null: false
    t.string   "company_name",  limit: 255, default: "", null: false
    t.string   "division_name", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["city"], name: "index_addresses_on_city", using: :btree
  add_index "addresses", ["customer_id"], name: "index_addresses_on_customer_id", using: :btree
  add_index "addresses", ["postal_code"], name: "index_addresses_on_postal_code", using: :btree
  add_index "addresses", ["prefecture", "city"], name: "index_addresses_on_prefecture_and_city", using: :btree
  add_index "addresses", ["type", "city"], name: "index_addresses_on_type_and_city", using: :btree
  add_index "addresses", ["type", "customer_id"], name: "index_addresses_on_type_and_customer_id", unique: true, using: :btree
  add_index "addresses", ["type", "prefecture", "city"], name: "index_addresses_on_type_and_prefecture_and_city", using: :btree

  create_table "administrators", force: :cascade do |t|
    t.string   "email",           limit: 255,                 null: false
    t.string   "email_for_index", limit: 255,                 null: false
    t.string   "hashed_password", limit: 255
    t.boolean  "suspended",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true, using: :btree

  create_table "allowed_sources", force: :cascade do |t|
    t.string   "namespace",  limit: 255,                 null: false
    t.integer  "octet1",     limit: 4,                   null: false
    t.integer  "octet2",     limit: 4,                   null: false
    t.integer  "octet3",     limit: 4,                   null: false
    t.integer  "octet4",     limit: 4,                   null: false
    t.boolean  "wildcard",               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "allowed_sources", ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "index_allowed_sources_on_namespace_and_octets", unique: true, using: :btree

  create_table "customer_interests", force: :cascade do |t|
    t.integer "customer_id", limit: 4, null: false
    t.integer "interest_id", limit: 4, null: false
  end

  add_index "customer_interests", ["customer_id", "interest_id"], name: "index_customer_interests_on_customer_id_and_interest_id", unique: true, using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "email",            limit: 255, null: false
    t.string   "email_for_index",  limit: 255, null: false
    t.string   "family_name",      limit: 255, null: false
    t.string   "given_name",       limit: 255, null: false
    t.string   "family_name_kana", limit: 255, null: false
    t.string   "given_name_kana",  limit: 255, null: false
    t.string   "gender",           limit: 255
    t.date     "birthday"
    t.string   "hashed_password",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "birth_year",       limit: 4
    t.integer  "birth_month",      limit: 4
    t.integer  "birth_mday",       limit: 4
    t.string   "job_title",        limit: 255
  end

  add_index "customers", ["birth_mday", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_mday_and_furigana", using: :btree
  add_index "customers", ["birth_mday", "given_name_kana"], name: "index_customers_on_birth_mday_and_given_name_kana", using: :btree
  add_index "customers", ["birth_mday"], name: "index_customers_on_birth_mday", using: :btree
  add_index "customers", ["birth_month", "birth_mday"], name: "index_customers_on_birth_month_and_birth_mday", using: :btree
  add_index "customers", ["birth_month", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_month_and_furigana", using: :btree
  add_index "customers", ["birth_month", "given_name_kana"], name: "index_customers_on_birth_month_and_given_name_kana", using: :btree
  add_index "customers", ["birth_year", "birth_month", "birth_mday"], name: "index_customers_on_birth_year_and_birth_month_and_birth_mday", using: :btree
  add_index "customers", ["birth_year", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_year_and_furigana", using: :btree
  add_index "customers", ["birth_year", "given_name_kana"], name: "index_customers_on_birth_year_and_given_name_kana", using: :btree
  add_index "customers", ["email_for_index"], name: "index_customers_on_email_for_index", unique: true, using: :btree
  add_index "customers", ["family_name_kana", "given_name_kana"], name: "index_customers_on_family_name_kana_and_given_name_kana", using: :btree
  add_index "customers", ["gender", "family_name_kana", "given_name_kana"], name: "index_customers_on_gender_and_furigana", using: :btree
  add_index "customers", ["given_name_kana"], name: "index_customers_on_given_name_kana", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "program_id",  limit: 4,                 null: false
    t.integer  "customer_id", limit: 4,                 null: false
    t.boolean  "approved",              default: false, null: false
    t.boolean  "canceled",              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["customer_id"], name: "index_entries_on_customer_id", using: :btree
  add_index "entries", ["program_id", "customer_id"], name: "index_entries_on_program_id_and_customer_id", unique: true, using: :btree

  create_table "hash_locks", force: :cascade do |t|
    t.string   "table",      limit: 255, null: false
    t.string   "column",     limit: 255, null: false
    t.string   "key",        limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hash_locks", ["table", "column", "key"], name: "index_hash_locks_on_table_and_column_and_key", unique: true, using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "message_tag_links", force: :cascade do |t|
    t.integer "message_id", limit: 4, null: false
    t.integer "tag_id",     limit: 4, null: false
  end

  add_index "message_tag_links", ["message_id", "tag_id"], name: "index_message_tag_links_on_message_id_and_tag_id", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "customer_id",     limit: 4,                     null: false
    t.integer  "staff_member_id", limit: 4
    t.integer  "root_id",         limit: 4
    t.integer  "parent_id",       limit: 4
    t.string   "type",            limit: 255,                   null: false
    t.string   "status",          limit: 255,   default: "new", null: false
    t.string   "subject",         limit: 255,                   null: false
    t.text     "body",            limit: 65535
    t.text     "remarks",         limit: 65535
    t.boolean  "discarded",                     default: false, null: false
    t.boolean  "deleted",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["customer_id", "deleted", "created_at"], name: "index_messages_on_customer_id_and_deleted_and_created_at", using: :btree
  add_index "messages", ["customer_id", "deleted", "status", "created_at"], name: "index_messages_on_c_d_s_c", using: :btree
  add_index "messages", ["customer_id", "discarded", "created_at"], name: "index_messages_on_customer_id_and_discarded_and_created_at", using: :btree
  add_index "messages", ["customer_id"], name: "index_messages_on_customer_id", using: :btree
  add_index "messages", ["parent_id"], name: "fk_rails_aafcb31dbf", using: :btree
  add_index "messages", ["root_id", "deleted", "created_at"], name: "index_messages_on_root_id_and_deleted_and_created_at", using: :btree
  add_index "messages", ["staff_member_id"], name: "index_messages_on_staff_member_id", using: :btree
  add_index "messages", ["type", "customer_id"], name: "index_messages_on_type_and_customer_id", using: :btree
  add_index "messages", ["type", "staff_member_id"], name: "index_messages_on_type_and_staff_member_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.integer  "customer_id",      limit: 4,                   null: false
    t.integer  "address_id",       limit: 4
    t.string   "number",           limit: 255,                 null: false
    t.string   "number_for_index", limit: 255,                 null: false
    t.boolean  "primary",                      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_four_digits", limit: 255
  end

  add_index "phones", ["address_id"], name: "index_phones_on_address_id", using: :btree
  add_index "phones", ["customer_id"], name: "index_phones_on_customer_id", using: :btree
  add_index "phones", ["last_four_digits"], name: "index_phones_on_last_four_digits", using: :btree
  add_index "phones", ["number_for_index"], name: "index_phones_on_number_for_index", using: :btree

  create_table "programs", force: :cascade do |t|
    t.integer  "registrant_id",              limit: 4,     null: false
    t.string   "title",                      limit: 255,   null: false
    t.text     "description",                limit: 65535
    t.datetime "application_start_time",                   null: false
    t.datetime "application_end_time",                     null: false
    t.integer  "min_number_of_participants", limit: 4
    t.integer  "max_number_of_participants", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["application_start_time"], name: "index_programs_on_application_start_time", using: :btree
  add_index "programs", ["registrant_id"], name: "index_programs_on_registrant_id", using: :btree

  create_table "staff_events", force: :cascade do |t|
    t.integer  "staff_member_id", limit: 4,   null: false
    t.string   "type",            limit: 255, null: false
    t.datetime "created_at",                  null: false
  end

  add_index "staff_events", ["created_at"], name: "index_staff_events_on_created_at", using: :btree
  add_index "staff_events", ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at", using: :btree

  create_table "staff_members", force: :cascade do |t|
    t.string   "email",            limit: 255,                 null: false
    t.string   "email_for_index",  limit: 255,                 null: false
    t.string   "family_name",      limit: 255,                 null: false
    t.string   "given_name",       limit: 255,                 null: false
    t.string   "family_name_kana", limit: 255,                 null: false
    t.string   "given_name_kana",  limit: 255,                 null: false
    t.string   "hashed_password",  limit: 255
    t.date     "start_date",                                   null: false
    t.date     "end_date"
    t.boolean  "suspended",                    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staff_members", ["email_for_index"], name: "index_staff_members_on_email_for_index", unique: true, using: :btree
  add_index "staff_members", ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "value", limit: 255, null: false
  end

  add_index "tags", ["value"], name: "index_tags_on_value", unique: true, using: :btree

  add_foreign_key "addresses", "customers"
  add_foreign_key "entries", "customers"
  add_foreign_key "entries", "programs"
  add_foreign_key "messages", "customers"
  add_foreign_key "messages", "messages", column: "parent_id"
  add_foreign_key "messages", "messages", column: "root_id"
  add_foreign_key "messages", "staff_members"
  add_foreign_key "phones", "addresses"
  add_foreign_key "phones", "customers"
  add_foreign_key "programs", "staff_members", column: "registrant_id"
  add_foreign_key "staff_events", "staff_members"
end
