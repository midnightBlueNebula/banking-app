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

ActiveRecord::Schema.define(version: 2020_09_28_150441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checking_accounts", force: :cascade do |t|
    t.decimal "balance"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false
    t.index ["user_id"], name: "index_checking_accounts_on_user_id"
  end

  create_table "depts", force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.date "expire"
    t.decimal "interest"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_depts_on_user_id"
  end

  create_table "interests", force: :cascade do |t|
    t.string "range"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string "occasion"
    t.string "activity_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "savings_accounts", force: :cascade do |t|
    t.decimal "balance"
    t.decimal "interest"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false
    t.index ["user_id"], name: "index_savings_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "is_admin", default: false
    t.boolean "is_employee", default: false
    t.boolean "is_customer", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "income", default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "checking_accounts", "users"
  add_foreign_key "depts", "users"
  add_foreign_key "logs", "users"
  add_foreign_key "savings_accounts", "users"
end
