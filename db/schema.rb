# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_29_151758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolio_projects", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "project_id", null: false
    t.integer "position"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["portfolio_id"], name: "index_portfolio_projects_on_portfolio_id"
    t.index ["project_id"], name: "index_portfolio_projects_on_project_id"
  end

  create_table "portfolio_users", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "user_id", null: false
    t.integer "inviter_id"
    t.string "role"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["portfolio_id"], name: "index_portfolio_users_on_portfolio_id"
    t.index ["user_id"], name: "index_portfolio_users_on_user_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "project_users", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.string "role"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "inviter_id"
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "scope"
    t.string "industry"
    t.string "stage"
    t.string "country"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "start_date"
    t.time "end_date"
    t.float "inflation_rate", default: 0.02
    t.float "income_tax_rate", default: 0.25
    t.float "valuation_factor", default: 5.0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "status", default: "active"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "portfolio_projects", "portfolios"
  add_foreign_key "portfolio_projects", "projects"
  add_foreign_key "portfolio_users", "portfolios"
  add_foreign_key "portfolio_users", "users"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
end
