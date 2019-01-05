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

ActiveRecord::Schema.define(version: 2019_01_05_154337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "account_type", default: 0, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "PLN", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "budget_entries", force: :cascade do |t|
    t.bigint "budget_id"
    t.bigint "setting_id"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "PLN", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_entries_on_budget_id"
    t.index ["setting_id"], name: "index_budget_entries_on_setting_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "setting_id"
    t.integer "operations_count", default: 0
    t.index ["setting_id"], name: "index_categories_on_setting_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.integer "final_value_cents", default: 0, null: false
    t.string "final_value_currency", default: "PLN", null: false
    t.integer "paid_value_cents", default: 0, null: false
    t.string "paid_value_currency", default: "PLN", null: false
    t.bigint "users_id"
    t.bigint "accounts_id"
    t.bigint "template_operations_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounts_id"], name: "index_goals_on_accounts_id"
    t.index ["template_operations_id"], name: "index_goals_on_template_operations_id"
    t.index ["users_id"], name: "index_goals_on_users_id"
  end

  create_table "operations", force: :cascade do |t|
    t.text "comment"
    t.integer "operation_type", default: 0, null: false
    t.bigint "user_id"
    t.bigint "account_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "PLN", null: false
    t.bigint "operation_id"
    t.date "paid_at"
    t.bigint "target_account_id"
    t.bigint "template_operation_id"
    t.index ["account_id"], name: "index_operations_on_account_id"
    t.index ["category_id"], name: "index_operations_on_category_id"
    t.index ["operation_id"], name: "index_operations_on_operation_id"
    t.index ["template_operation_id"], name: "index_operations_on_template_operation_id"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "template_operations", force: :cascade do |t|
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "PLN", null: false
    t.text "comment"
    t.integer "operation_type", default: 0, null: false
    t.bigint "user_id"
    t.bigint "account_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "planned_at"
    t.bigint "target_account_id"
    t.string "name"
    t.index ["account_id"], name: "index_template_operations_on_account_id"
    t.index ["category_id"], name: "index_template_operations_on_category_id"
    t.index ["user_id"], name: "index_template_operations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
end
