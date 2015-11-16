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

ActiveRecord::Schema.define(version: 20140101000020) do

  create_table "addresses", force: true do |t|
    t.integer  "customer_id",                null: false
    t.string   "type",                       null: false
    t.string   "postal_code",                null: false
    t.string   "prefecture",                 null: false
    t.string   "city",                       null: false
    t.string   "address1",                   null: false
    t.string   "address2",                   null: false
    t.string   "company_name",  default: "", null: false
    t.string   "division_name", default: "", null: false
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

  create_table "administrators", force: true do |t|
    t.string   "email",                           null: false
    t.string   "email_for_index",                 null: false
    t.string   "hashed_password"
    t.boolean  "suspended",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true, using: :btree

  create_table "allowed_sources", force: true do |t|
    t.string   "namespace",                  null: false
    t.integer  "octet1",                     null: false
    t.integer  "octet2",                     null: false
    t.integer  "octet3",                     null: false
    t.integer  "octet4",                     null: false
    t.boolean  "wildcard",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "allowed_sources", ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "index_allowed_sources_on_namespace_and_octets", unique: true, using: :btree

  create_table "customers", force: true do |t|
    t.string   "email",            null: false
    t.string   "email_for_index",  null: false
    t.string   "family_name",      null: false
    t.string   "given_name",       null: false
    t.string   "family_name_kana", null: false
    t.string   "given_name_kana",  null: false
    t.string   "gender"
    t.date     "birthday"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "birth_year"
    t.integer  "birth_month"
    t.integer  "birth_mday"
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

  create_table "entries", force: true do |t|
    t.integer  "program_id",                  null: false
    t.integer  "customer_id",                 null: false
    t.boolean  "approved",    default: false, null: false
    t.boolean  "canceled",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["customer_id"], name: "index_entries_on_customer_id", using: :btree
  add_index "entries", ["program_id", "customer_id"], name: "index_entries_on_program_id_and_customer_id", unique: true, using: :btree

  create_table "hash_locks", force: true do |t|
    t.string   "table",      null: false
    t.string   "column",     null: false
    t.string   "key",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hash_locks", ["table", "column", "key"], name: "index_hash_locks_on_table_and_column_and_key", unique: true, using: :btree

  create_table "message_tag_links", force: true do |t|
    t.integer "message_id", null: false
    t.integer "tag_id",     null: false
  end

  add_index "message_tag_links", ["message_id", "tag_id"], name: "index_message_tag_links_on_message_id_and_tag_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "customer_id",                     null: false
    t.integer  "staff_member_id"
    t.integer  "root_id"
    t.integer  "parent_id"
    t.string   "type",                            null: false
    t.string   "status",          default: "new", null: false
    t.string   "subject",                         null: false
    t.text     "body"
    t.text     "remarks"
    t.boolean  "discarded",       default: false, null: false
    t.boolean  "deleted",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["customer_id", "deleted", "created_at"], name: "index_messages_on_customer_id_and_deleted_and_created_at", using: :btree
  add_index "messages", ["customer_id", "deleted", "status", "created_at"], name: "index_messages_on_c_d_s_c", using: :btree
  add_index "messages", ["customer_id", "discarded", "created_at"], name: "index_messages_on_customer_id_and_discarded_and_created_at", using: :btree
  add_index "messages", ["customer_id"], name: "index_messages_on_customer_id", using: :btree
  add_index "messages", ["parent_id"], name: "messages_parent_id_fk", using: :btree
  add_index "messages", ["root_id", "deleted", "created_at"], name: "index_messages_on_root_id_and_deleted_and_created_at", using: :btree
  add_index "messages", ["staff_member_id"], name: "index_messages_on_staff_member_id", using: :btree
  add_index "messages", ["type", "customer_id"], name: "index_messages_on_type_and_customer_id", using: :btree
  add_index "messages", ["type", "staff_member_id"], name: "index_messages_on_type_and_staff_member_id", using: :btree

  create_table "phones", force: true do |t|
    t.integer  "customer_id",                      null: false
    t.integer  "address_id"
    t.string   "number",                           null: false
    t.string   "number_for_index",                 null: false
    t.boolean  "primary",          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_four_digits"
  end

  add_index "phones", ["address_id"], name: "index_phones_on_address_id", using: :btree
  add_index "phones", ["customer_id"], name: "index_phones_on_customer_id", using: :btree
  add_index "phones", ["last_four_digits"], name: "index_phones_on_last_four_digits", using: :btree
  add_index "phones", ["number_for_index"], name: "index_phones_on_number_for_index", using: :btree

  create_table "programs", force: true do |t|
    t.integer  "registrant_id",              null: false
    t.string   "title",                      null: false
    t.text     "description"
    t.datetime "application_start_time",     null: false
    t.datetime "application_end_time",       null: false
    t.integer  "min_number_of_participants"
    t.integer  "max_number_of_participants"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["application_start_time"], name: "index_programs_on_application_start_time", using: :btree
  add_index "programs", ["registrant_id"], name: "index_programs_on_registrant_id", using: :btree

  create_table "staff_events", force: true do |t|
    t.integer  "staff_member_id", null: false
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
  end

  add_index "staff_events", ["created_at"], name: "index_staff_events_on_created_at", using: :btree
  add_index "staff_events", ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at", using: :btree

  create_table "staff_members", force: true do |t|
    t.string   "email",                            null: false
    t.string   "email_for_index",                  null: false
    t.string   "family_name",                      null: false
    t.string   "given_name",                       null: false
    t.string   "family_name_kana",                 null: false
    t.string   "given_name_kana",                  null: false
    t.string   "hashed_password"
    t.date     "start_date",                       null: false
    t.date     "end_date"
    t.boolean  "suspended",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staff_members", ["email_for_index"], name: "index_staff_members_on_email_for_index", unique: true, using: :btree
  add_index "staff_members", ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana", using: :btree

  create_table "tags", force: true do |t|
    t.string "value", null: false
  end

  add_index "tags", ["value"], name: "index_tags_on_value", unique: true, using: :btree

  add_foreign_key "addresses", "customers", name: "addresses_customer_id_fk"

  add_foreign_key "entries", "customers", name: "entries_customer_id_fk"
  add_foreign_key "entries", "programs", name: "entries_program_id_fk"

  add_foreign_key "messages", "customers", name: "messages_customer_id_fk"
  add_foreign_key "messages", "messages", name: "messages_parent_id_fk", column: "parent_id"
  add_foreign_key "messages", "messages", name: "messages_root_id_fk", column: "root_id"
  add_foreign_key "messages", "staff_members", name: "messages_staff_member_id_fk"

  add_foreign_key "phones", "addresses", name: "phones_address_id_fk"
  add_foreign_key "phones", "customers", name: "phones_customer_id_fk"

  add_foreign_key "programs", "staff_members", name: "programs_registrant_id_fk", column: "registrant_id"

  add_foreign_key "staff_events", "staff_members", name: "staff_events_staff_member_id_fk"

end
