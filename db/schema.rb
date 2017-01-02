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

ActiveRecord::Schema.define(version: 20161229111108) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["name"], name: "index_brands_on_name", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "deleted_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "checkouts", force: :cascade do |t|
    t.integer  "item_id",     limit: 4,   null: false
    t.date     "checkout",                null: false
    t.date     "check_in"
    t.string   "reason",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id", limit: 4
  end

  add_index "checkouts", ["employee_id"], name: "index_checkouts_on_employee_id", using: :btree
  add_index "checkouts", ["item_id"], name: "fk_rails_4c37c40778", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
    t.integer  "item_id",                 limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                   limit: 255
  end

  add_index "documents", ["item_id"], name: "fk_rails_9fa64cfbd0", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name",        limit: 255,                null: false
    t.string   "email",       limit: 255
    t.boolean  "active",                  default: true
    t.integer  "external_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "item_id",       limit: 4
    t.integer  "system_id",     limit: 4
    t.string   "title",         limit: 255,   null: false
    t.text     "description",   limit: 65535
    t.date     "closed_at"
    t.text     "note",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resolution_id", limit: 4
    t.integer  "priority",      limit: 4
  end

  add_index "issues", ["item_id"], name: "fk_rails_e682dcd997", using: :btree
  add_index "issues", ["resolution_id"], name: "fk_rails_067853e228", using: :btree
  add_index "issues", ["system_id"], name: "fk_rails_972b513577", using: :btree

  create_table "item_histories", force: :cascade do |t|
    t.integer  "item_id",     limit: 4,   null: false
    t.boolean  "status",                  null: false
    t.integer  "system_id",   limit: 4
    t.string   "note",        limit: 500
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id", limit: 4
  end

  add_index "item_histories", ["employee_id"], name: "index_item_histories_on_employee_id", using: :btree
  add_index "item_histories", ["item_id"], name: "fk_rails_8474d7045a", using: :btree
  add_index "item_histories", ["system_id"], name: "fk_rails_d3de93f21e", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "model_number",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",         limit: 4,                    null: false
    t.integer  "brand_id",            limit: 4
    t.integer  "system_id",           limit: 4
    t.string   "serial_number",       limit: 255
    t.date     "purchase_on"
    t.boolean  "working",                           default: true
    t.date     "warranty_expires_on"
    t.integer  "vendor_id",           limit: 4
    t.date     "discarded_at"
    t.date     "deleted_at"
    t.text     "note",                limit: 65535
    t.integer  "employee_id",         limit: 4
  end

  add_index "items", ["brand_id"], name: "fk_rails_36708b3aa6", using: :btree
  add_index "items", ["category_id"], name: "fk_rails_89fb86dc8b", using: :btree
  add_index "items", ["employee_id"], name: "index_items_on_employee_id", using: :btree
  add_index "items", ["system_id"], name: "index_items_on_system_id", using: :btree
  add_index "items", ["vendor_id"], name: "fk_rails_e1bcf5469c", using: :btree

  create_table "resolutions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_histories", force: :cascade do |t|
    t.integer  "system_id",   limit: 4,     null: false
    t.boolean  "status",                    null: false
    t.text     "note",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id", limit: 4
  end

  add_index "system_histories", ["employee_id"], name: "index_system_histories_on_employee_id", using: :btree
  add_index "system_histories", ["system_id"], name: "fk_rails_ccba30084c", using: :btree

  create_table "systems", force: :cascade do |t|
    t.date     "assembled_on"
    t.date     "discarded_at"
    t.boolean  "working",                    default: true
    t.text     "note",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id",  limit: 4
  end

  add_index "systems", ["employee_id"], name: "index_systems_on_employee_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",        limit: 255, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "access_token", limit: 255
    t.string   "google_uid",   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "email",      limit: 255
    t.string   "mobile",     limit: 255
    t.string   "address",    limit: 255, null: false
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "checkouts", "employees"
  add_foreign_key "checkouts", "items"
  add_foreign_key "documents", "items"
  add_foreign_key "issues", "items"
  add_foreign_key "issues", "resolutions"
  add_foreign_key "issues", "systems"
  add_foreign_key "item_histories", "employees"
  add_foreign_key "item_histories", "items"
  add_foreign_key "item_histories", "systems"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "employees"
  add_foreign_key "items", "systems"
  add_foreign_key "items", "vendors"
  add_foreign_key "system_histories", "employees"
  add_foreign_key "system_histories", "systems"
  add_foreign_key "systems", "employees"
end
