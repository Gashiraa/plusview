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

ActiveRecord::Schema.define(version: 2019_02_28_104951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "pwd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "mail"
    t.integer "tva_record"
    t.string "street"
    t.integer "number"
    t.integer "cp"
    t.string "locality"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "payment_id"
    t.date "date"
    t.integer "status"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_invoices_on_payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.date "date"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "invoice_id"
    t.bigint "quotation_id"
    t.bigint "customer_id"
    t.integer "status"
    t.integer "wielding"
    t.integer "machining"
    t.integer "karcher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_projects_on_customer_id"
    t.index ["invoice_id"], name: "index_projects_on_invoice_id"
    t.index ["quotation_id"], name: "index_projects_on_quotation_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.date "date"
    t.integer "status"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "invoice_id"
    t.bigint "customer_id"
    t.bigint "quotation_id"
    t.string "name"
    t.string "comment"
    t.float "hourly_rate"
    t.float "coefficient"
    t.date "date"
    t.time "duration"
    t.integer "status"
    t.float "tva_rate"
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_services_on_customer_id"
    t.index ["invoice_id"], name: "index_services_on_invoice_id"
    t.index ["project_id"], name: "index_services_on_project_id"
    t.index ["quotation_id"], name: "index_services_on_quotation_id"
  end

  create_table "wares", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "invoice_id"
    t.bigint "customer_id"
    t.bigint "quotation_id"
    t.string "name"
    t.string "comment"
    t.integer "quantity"
    t.float "provider_discount"
    t.float "margin"
    t.float "unit_price"
    t.integer "status"
    t.float "tva_rate"
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_wares_on_customer_id"
    t.index ["invoice_id"], name: "index_wares_on_invoice_id"
    t.index ["project_id"], name: "index_wares_on_project_id"
    t.index ["quotation_id"], name: "index_wares_on_quotation_id"
  end

  add_foreign_key "invoices", "payments"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "invoices"
  add_foreign_key "projects", "quotations"
  add_foreign_key "services", "customers"
  add_foreign_key "services", "invoices"
  add_foreign_key "services", "projects"
  add_foreign_key "services", "quotations"
  add_foreign_key "wares", "customers"
  add_foreign_key "wares", "invoices"
  add_foreign_key "wares", "projects"
  add_foreign_key "wares", "quotations"
end
