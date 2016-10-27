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

ActiveRecord::Schema.define(version: 20161027122147) do

  create_table "allocation_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "user_id"], name: "index_allocation_histories_on_item_id_and_user_id", using: :btree
    t.index ["item_id"], name: "index_allocation_histories_on_item_id", using: :btree
    t.index ["user_id"], name: "index_allocation_histories_on_user_id", using: :btree
  end

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", unique: true, using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email",                      null: false
    t.string   "mobile"
    t.string   "designation",                null: false
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "model_number",        limit: 50,                   null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "category_id",                                      null: false
    t.integer  "brand_id",                                         null: false
    t.integer  "employee_id"
    t.integer  "system_id"
    t.string   "serial_number",                                    null: false
    t.date     "purchase_on",                                      null: false
    t.string   "purchase_from",                                    null: false
    t.text     "purchase_note",       limit: 65535
    t.boolean  "working",                           default: true
    t.date     "warrenty_expired_on"
    t.index ["brand_id"], name: "fk_rails_36708b3aa6", using: :btree
    t.index ["category_id"], name: "fk_rails_89fb86dc8b", using: :btree
    t.index ["employee_id"], name: "index_items_on_employee_id", using: :btree
    t.index ["system_id"], name: "index_items_on_system_id", using: :btree
  end

  create_table "systems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id",                               null: false
    t.date     "build_on"
    t.date     "discarted_at"
    t.boolean  "working",                    default: true
    t.text     "note",         limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["employee_id"], name: "index_systems_on_employee_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "first_name",   null: false
    t.string   "last_name"
    t.string   "access_token", null: false
    t.string   "google_uid",   null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "employees"
  add_foreign_key "items", "systems"
  add_foreign_key "systems", "employees"
end
