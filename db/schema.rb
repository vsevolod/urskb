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

ActiveRecord::Schema.define(version: 20150122063303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "old_id"
    t.string   "number"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "collection"
    t.integer  "name_id"
    t.integer  "agreement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_type",      limit: 255
    t.string   "state",             limit: 255
    t.integer  "currency_id",       limit: 4
    t.integer  "owner_id",          limit: 4
    t.integer  "account_client_id", limit: 4
    t.string   "class_id",          limit: 255
    t.text     "options",           limit: 2147483647
    t.integer  "client_id",         limit: 4
  end

  add_index "accounts", ["account_client_id"], name: "index_accounts_on_account_client_id"
  add_index "accounts", ["agreement_id"], name: "index_accounts_on_agreement_id"
  add_index "accounts", ["client_id"], name: "index_accounts_on_client_id"
  add_index "accounts", ["currency_id"], name: "index_accounts_on_currency_id"
  add_index "accounts", ["name_id"], name: "index_accounts_on_name_id"
  add_index "accounts", ["number"], name: "index_accounts_on_number"
  add_index "accounts", ["owner_id"], name: "index_accounts_on_owner_id"

  create_table "accounts_dates", force: :cascade do |t|
    t.integer  "account_id"
    t.text     "options"
    t.float    "balance"
    t.float    "currency_balance"
    t.integer  "division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts_dates", ["account_id"], name: "index_accounts_dates_on_account_id", using: :btree
  add_index "accounts_dates", ["division_id"], name: "index_accounts_dates_on_division_id", using: :btree

  create_table "agreements", force: :cascade do |t|
    t.string   "old_id"
    t.string   "updog"
    t.string   "type"
    t.string   "state"
    t.string   "number"
    t.text     "options"
    t.date     "start_date"
    t.date     "end_date_plan"
    t.date     "end_date_fact"
    t.string   "ancestry"
    t.float    "sum"
    t.integer  "client_id"
    t.integer  "division_id"
    t.integer  "currency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agreements", ["client_id"], name: "index_agreements_on_client_id", using: :btree
  add_index "agreements", ["currency_id"], name: "index_agreements_on_currency_id", using: :btree
  add_index "agreements", ["division_id"], name: "index_agreements_on_division_id", using: :btree
  add_index "agreements", ["type"], name: "index_agreements_on_type", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "old_id"
    t.string   "id_crm"
    t.string   "name"
    t.string   "inn"
    t.string   "kpp"
    t.integer  "low_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "options"
  end

  add_index "clients", ["low_form_id"], name: "index_clients_on_low_form_id", using: :btree

  create_table "clients_segments", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "segment_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients_segments", ["client_id"], name: "index_clients_segments_on_client_id", using: :btree
  add_index "clients_segments", ["segment_id"], name: "index_clients_segments_on_segment_id", using: :btree

  create_table "dictionaries", force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "ancestry"
    t.string   "old_name"
    t.string   "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "value",      limit: 2147483647
  end

  add_index "dictionaries", ["ancestry"], name: "index_dictionaries_on_ancestry", using: :btree

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "object_type_id"
    t.string   "ancestry"
    t.string   "state"
    t.date     "open_date"
    t.date     "close_date"
    t.text     "comment"
    t.string   "old_name"
    t.string   "old_number"
    t.boolean  "fl_ato"
    t.string   "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "divisions", ["object_type_id"], name: "index_divisions_on_object_type_id", using: :btree

  create_table "indicator_rules", force: :cascade do |t|
    t.integer  "level"
    t.integer  "parent_indicator_id"
    t.integer  "child_indicator_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_rules", ["child_indicator_id"], name: "index_indicator_rules_on_child_indicator_id", using: :btree
  add_index "indicator_rules", ["parent_indicator_id"], name: "index_indicator_rules_on_parent_indicator_id", using: :btree

  create_table "indicators", force: :cascade do |t|
    t.string   "name"
    t.string   "sh_name"
    t.integer  "sign_type_id"
    t.text     "comment"
    t.integer  "date_type_id"
    t.integer  "object_type_id"
    t.integer  "product_id"
    t.integer  "accum_level_id"
    t.string   "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicators", ["accum_level_id"], name: "index_indicators_on_accum_level_id", using: :btree
  add_index "indicators", ["date_type_id"], name: "index_indicators_on_date_type_id", using: :btree
  add_index "indicators", ["object_type_id"], name: "index_indicators_on_object_type_id", using: :btree
  add_index "indicators", ["product_id"], name: "index_indicators_on_product_id", using: :btree
  add_index "indicators", ["sign_type_id"], name: "index_indicators_on_sign_type_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.string   "objectable_type"
    t.integer  "objectable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["objectable_id", "objectable_type"], name: "index_options_on_objectable_id_and_objectable_type", using: :btree

end
