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

ActiveRecord::Schema.define(version: 20161206051611) do

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

  create_table "checkouts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item_id",     null: false
    t.date     "checkout",    null: false
    t.date     "check_in"
    t.string   "reason",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "employee_id"
    t.index ["item_id"], name: "index_checkouts_on_item_id", using: :btree
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "item_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title"
    t.index ["item_id"], name: "index_documents_on_item_id", using: :btree
  end

  create_table "issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item_id"
    t.integer  "system_id"
    t.string   "title",                       null: false
    t.text     "description",   limit: 65535
    t.date     "closed_at"
    t.text     "note",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "resolution_id"
    t.integer  "priority"
    t.index ["item_id"], name: "index_issues_on_item_id", using: :btree
    t.index ["resolution_id"], name: "index_issues_on_resolution_id", using: :btree
    t.index ["system_id"], name: "index_issues_on_system_id", using: :btree
  end

  create_table "item_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item_id",                 null: false
    t.boolean  "status",                  null: false
    t.integer  "system_id"
    t.string   "note",        limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "employee_id"
    t.index ["item_id"], name: "index_item_histories_on_item_id", using: :btree
    t.index ["system_id"], name: "index_item_histories_on_system_id", using: :btree
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "model_number"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "category_id",                        null: false
    t.integer  "brand_id"
    t.integer  "system_id"
    t.string   "serial_number",                      null: false
    t.date     "purchase_on"
    t.boolean  "working",             default: true
    t.date     "warranty_expires_on"
    t.integer  "vendor_id"
    t.date     "discarded_at"
    t.integer  "employee_id"
    t.date     "deleted_at"
    t.index ["brand_id"], name: "fk_rails_36708b3aa6", using: :btree
    t.index ["category_id"], name: "fk_rails_89fb86dc8b", using: :btree
    t.index ["system_id"], name: "index_items_on_system_id", using: :btree
    t.index ["vendor_id"], name: "index_items_on_vendor_id", using: :btree
  end

  create_table "resolutions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "system_id",                 null: false
    t.boolean  "status",                    null: false
    t.text     "note",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "employee_id"
    t.index ["system_id"], name: "index_system_histories_on_system_id", using: :btree
  end

  create_table "systems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "assembled_on"
    t.date     "discarded_at"
    t.boolean  "working",                    default: true
    t.text     "note",         limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "employee_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "access_token"
    t.string   "google_uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "vendors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.string   "mobile"
    t.string   "address",    null: false
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "checkouts", "items"
  add_foreign_key "documents", "items"
  add_foreign_key "issues", "items"
  add_foreign_key "issues", "resolutions"
  add_foreign_key "issues", "systems"
  add_foreign_key "item_histories", "items"
  add_foreign_key "item_histories", "systems"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "systems"
  add_foreign_key "items", "vendors"
  add_foreign_key "system_histories", "systems"
end
