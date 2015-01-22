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

ActiveRecord::Schema.define(version: 20150122082151) do

# Could not dump table "NPL5" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "accounts", force: :cascade do |t|
    t.string   "old_id",            limit: 255
    t.string   "number",            limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.string   "collection",        limit: 255
    t.integer  "name_id",           limit: 4
    t.integer  "agreement_id",      limit: 4
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
    t.integer  "account_id",       limit: 4
    t.text     "options",          limit: 2147483647
    t.float    "balance",          limit: 24
    t.float    "currency_balance", limit: 24
    t.integer  "division_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts_dates", ["account_id"], name: "index_accounts_dates_on_account_id"
  add_index "accounts_dates", ["division_id"], name: "index_accounts_dates_on_division_id"

  create_table "agreements", force: :cascade do |t|
    t.string   "old_id",        limit: 255
    t.string   "updog",         limit: 255
    t.string   "type",          limit: 255
    t.string   "state",         limit: 255
    t.string   "number",        limit: 255
    t.text     "options",       limit: 2147483647
    t.date     "start_date"
    t.date     "end_date_plan"
    t.date     "end_date_fact"
    t.string   "ancestry",      limit: 255
    t.float    "sum",           limit: 24
    t.integer  "client_id",     limit: 4
    t.integer  "division_id",   limit: 4
    t.integer  "currency_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agreements", ["client_id"], name: "index_agreements_on_client_id"
  add_index "agreements", ["currency_id"], name: "index_agreements_on_currency_id"
  add_index "agreements", ["division_id"], name: "index_agreements_on_division_id"

  create_table "clients", force: :cascade do |t|
    t.string   "old_id",      limit: 255
    t.string   "id_crm",      limit: 255
    t.string   "name",        limit: 255
    t.string   "inn",         limit: 255
    t.string   "kpp",         limit: 255
    t.integer  "low_form_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "options",     limit: 2147483647
  end

  add_index "clients", ["low_form_id"], name: "index_clients_on_low_form_id"

  create_table "clients_segments", force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.integer  "segment_id", limit: 4
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients_segments", ["client_id"], name: "index_clients_segments_on_client_id"
  add_index "clients_segments", ["segment_id"], name: "index_clients_segments_on_segment_id"

  create_table "dictionaries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "tag",        limit: 255
    t.string   "ancestry",   limit: 255
    t.string   "old_name",   limit: 255
    t.string   "old_id",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "value",      limit: 2147483647
  end

  add_index "dictionaries", ["ancestry"], name: "index_dictionaries_on_ancestry"

  create_table "divisions", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "number",         limit: 255
    t.integer  "object_type_id", limit: 4
    t.string   "ancestry",       limit: 255
    t.string   "state",          limit: 255
    t.date     "open_date"
    t.date     "close_date"
    t.text     "comment",        limit: 2147483647
    t.string   "old_name",       limit: 255
    t.string   "old_number",     limit: 255
    t.boolean  "fl_ato"
    t.string   "old_id",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "divisions", ["object_type_id"], name: "index_divisions_on_object_type_id"

  create_table "indicator_rules", force: :cascade do |t|
    t.integer  "level",               limit: 4
    t.integer  "parent_indicator_id", limit: 4
    t.integer  "child_indicator_id",  limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.string   "old_id",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicator_rules", ["child_indicator_id"], name: "index_indicator_rules_on_child_indicator_id"
  add_index "indicator_rules", ["parent_indicator_id"], name: "index_indicator_rules_on_parent_indicator_id"

  create_table "indicators", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "sh_name",        limit: 255
    t.integer  "sign_type_id",   limit: 4
    t.text     "comment",        limit: 2147483647
    t.integer  "date_type_id",   limit: 4
    t.integer  "object_type_id", limit: 4
    t.integer  "product_id",     limit: 4
    t.integer  "accum_level_id", limit: 4
    t.string   "old_id",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "indicators", ["accum_level_id"], name: "index_indicators_on_accum_level_id"
  add_index "indicators", ["date_type_id"], name: "index_indicators_on_date_type_id"
  add_index "indicators", ["object_type_id"], name: "index_indicators_on_object_type_id"
  add_index "indicators", ["product_id"], name: "index_indicators_on_product_id"
  add_index "indicators", ["sign_type_id"], name: "index_indicators_on_sign_type_id"

  create_table "options", force: :cascade do |t|
    t.string   "key",             limit: 255
    t.string   "value",           limit: 255
    t.string   "objectable_type", limit: 255
    t.integer  "objectable_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["objectable_id", "objectable_type"], name: "index_options_on_objectable_id_and_objectable_type"

end
