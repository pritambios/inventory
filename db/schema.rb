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

ActiveRecord::Schema.define(version: 2017_09_19_124802) do

  create_table "brands", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deleted_at"
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deleted_at"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "checkouts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "item_id", null: false
    t.date "checkout", null: false
    t.date "check_in"
    t.string "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id"
    t.index ["item_id"], name: "fk_rails_4c37c40778"
  end

  create_table "documents", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["item_id"], name: "fk_rails_9fa64cfbd0"
  end

  create_table "employees", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.boolean "active", default: true
    t.integer "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "google_uid"
    t.index ["external_id"], name: "index_employees_on_external_id", unique: true
  end

  create_table "issues", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "item_id"
    t.string "title", null: false
    t.text "description"
    t.date "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "resolution_id"
    t.integer "priority"
    t.integer "employee_id"
    t.index ["item_id"], name: "fk_rails_e682dcd997"
    t.index ["resolution_id"], name: "fk_rails_067853e228"
  end

  create_table "item_histories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "item_id", null: false
    t.boolean "status", null: false
    t.string "note", limit: 500
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id"
    t.integer "parent_id"
    t.index ["item_id"], name: "fk_rails_8474d7045a"
  end

  create_table "items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "model_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id", null: false
    t.integer "brand_id"
    t.string "serial_number"
    t.date "purchase_on"
    t.boolean "working", default: true
    t.date "warranty_expires_on"
    t.integer "vendor_id"
    t.date "discarded_at"
    t.integer "employee_id"
    t.date "deleted_at"
    t.text "note"
    t.string "discard_reason"
    t.integer "parent_id"
    t.integer "approved_by_id"
    t.integer "rejected_by_id"
    t.datetime "approved_at"
    t.datetime "rejected_at"
    t.index ["approved_by_id"], name: "fk_rails_e88dd3cf0f"
    t.index ["brand_id"], name: "fk_rails_36708b3aa6"
    t.index ["category_id"], name: "fk_rails_89fb86dc8b"
    t.index ["rejected_by_id"], name: "fk_rails_38f7d03ed0"
    t.index ["vendor_id"], name: "fk_rails_e1bcf5469c"
  end

  create_table "resolutions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "access_token"
    t.string "google_uid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vendors", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "mobile"
    t.string "address", null: false
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "checkouts", "items"
  add_foreign_key "documents", "items"
  add_foreign_key "issues", "items"
  add_foreign_key "issues", "resolutions"
  add_foreign_key "item_histories", "items"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users", column: "approved_by_id"
  add_foreign_key "items", "users", column: "rejected_by_id"
  add_foreign_key "items", "vendors"
end
