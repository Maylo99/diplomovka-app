# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_24_094325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "accounting_type"
    t.string "register_text"
    t.string "country"
    t.string "legal_form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_account_id"
    t.index ["invoice_account_id"], name: "index_accounts_on_invoice_account_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "register_number", limit: 30
    t.string "contact", limit: 100
    t.string "street"
    t.string "city"
    t.string "postal_code", limit: 10
    t.string "street_number"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "currency", limit: 10, null: false
    t.string "iban", limit: 50, null: false
    t.string "swift_code", limit: 15, null: false
    t.string "account_number", null: false
    t.string "bank_code", limit: 10
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_bank_accounts_on_account_id"
  end

  create_table "expense_items", force: :cascade do |t|
    t.string "name"
    t.decimal "quantity"
    t.decimal "vat_rate"
    t.decimal "unit_price"
    t.bigint "expense_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_items_on_expense_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "receipt_id"
    t.string "cash_register_code"
    t.datetime "issue_date"
    t.string "okp"
    t.string "receipt_number"
    t.string "country"
    t.bigint "account_id", null: false
    t.bigint "invoice_account_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_expenses_on_account_id"
    t.index ["invoice_account_id"], name: "index_expenses_on_invoice_account_id"
    t.index ["unit_id"], name: "index_expenses_on_unit_id"
  end

  create_table "invoice_accounts", force: :cascade do |t|
    t.string "vat_payer_type"
    t.string "registration_id", limit: 100
    t.string "tax_id", limit: 100
    t.string "vat_id", limit: 100
    t.string "phone_number", limit: 20
    t.string "email"
    t.string "web"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_address_id"
    t.bigint "postal_address_id"
    t.index ["invoice_address_id"], name: "index_invoice_accounts_on_invoice_address_id"
    t.index ["postal_address_id"], name: "index_invoice_accounts_on_postal_address_id"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.string "name"
    t.decimal "quantity"
    t.string "measure_unit"
    t.decimal "unit_price"
    t.decimal "vat_rate"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.date "issue_date"
    t.date "delivery_date"
    t.date "due_date"
    t.string "number"
    t.string "payment_method"
    t.string "variable_symbol"
    t.string "order_number"
    t.bigint "purchaser_id"
    t.bigint "supplier_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_invoices_on_account_id"
    t.index ["purchaser_id"], name: "index_invoices_on_purchaser_id"
    t.index ["supplier_id"], name: "index_invoices_on_supplier_id"
  end

  create_table "partners", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "client_id", null: false
    t.string "name", null: false
    t.index ["account_id"], name: "index_partners_on_account_id"
    t.index ["client_id"], name: "index_partners_on_client_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "user_role"
    t.boolean "default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "account_id"
    t.index ["account_id", "user_id"], name: "index_user_accounts_on_account_id_and_user_id", unique: true
    t.index ["account_id"], name: "index_user_accounts_on_account_id"
    t.index ["user_id"], name: "index_user_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "invoice_accounts"
  add_foreign_key "bank_accounts", "accounts"
  add_foreign_key "expense_items", "expenses"
  add_foreign_key "expenses", "accounts"
  add_foreign_key "expenses", "addresses", column: "unit_id"
  add_foreign_key "expenses", "invoice_accounts"
  add_foreign_key "invoice_accounts", "addresses", column: "invoice_address_id"
  add_foreign_key "invoice_accounts", "addresses", column: "postal_address_id"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoices", "accounts"
  add_foreign_key "invoices", "invoice_accounts", column: "purchaser_id"
  add_foreign_key "invoices", "invoice_accounts", column: "supplier_id"
  add_foreign_key "partners", "accounts"
  add_foreign_key "partners", "invoice_accounts", column: "client_id"
end
