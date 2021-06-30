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

ActiveRecord::Schema.define(version: 2021_06_30_205045) do

  create_table "business_users", force: :cascade do |t|
    t.integer "business_id"
    t.integer "user_id"
    t.integer "role_id"
    t.index ["business_id"], name: "index_business_users_on_business_id"
    t.index ["role_id"], name: "index_business_users_on_role_id"
    t.index ["user_id"], name: "index_business_users_on_user_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.string "phone"
    t.integer "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_businesses_on_owner_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "type"
    t.text "description"
    t.string "address"
    t.integer "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_jobs_on_business_id"
  end

  create_table "role_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_roles_on_category_id"
  end

  create_table "tradesmen_profile_users", force: :cascade do |t|
    t.integer "tradesmen_profile_id", null: false
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_tradesmen_profile_users_on_role_id"
    t.index ["tradesmen_profile_id"], name: "index_tradesmen_profile_users_on_tradesmen_profile_id"
    t.index ["user_id"], name: "index_tradesmen_profile_users_on_user_id"
  end

  create_table "tradesmen_profiles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_tradesmen_profiles_on_owner_id"
  end

  create_table "tradesmen_profiles_trades", id: false, force: :cascade do |t|
    t.integer "tradesmen_profile_id", null: false
    t.integer "tradesmen_trade_id", null: false
    t.index ["tradesmen_profile_id"], name: "index_tradesmen_profiles_trades_on_tradesmen_profile_id"
    t.index ["tradesmen_trade_id"], name: "index_tradesmen_profiles_trades_on_tradesmen_trade_id"
  end

  create_table "tradesmen_trades", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "phone"
    t.string "phone2"
    t.date "date_of_birth"
    t.integer "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "businesses", "users", column: "owner_id"
  add_foreign_key "jobs", "businesses"
  add_foreign_key "tradesmen_profile_users", "roles"
  add_foreign_key "tradesmen_profile_users", "tradesmen_profiles"
  add_foreign_key "tradesmen_profile_users", "users"
  add_foreign_key "tradesmen_profiles", "users", column: "owner_id"
  add_foreign_key "users", "roles"
end
