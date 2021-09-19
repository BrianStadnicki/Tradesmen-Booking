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

ActiveRecord::Schema.define(version: 2021_09_19_193751) do

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
    t.string "phone2"
    t.string "email"
    t.index ["owner_id"], name: "index_businesses_on_owner_id"
  end

  create_table "businesses_tradesmen_profiles", force: :cascade do |t|
    t.integer "business_id", null: false
    t.integer "tradesmen_profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id", "tradesmen_profile_id"], name: "index_on_businesses_tradesmen_profiles_uniqueness", unique: true
    t.index ["business_id"], name: "index_businesses_tradesmen_profiles_on_business_id"
    t.index ["tradesmen_profile_id"], name: "index_businesses_tradesmen_profiles_on_tradesmen_profile_id"
  end

  create_table "job_tradesmen_applications", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "tradesmen_profile_id", null: false
    t.date "date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "quote", precision: 8, scale: 2
    t.boolean "morning"
    t.boolean "afternoon"
    t.index ["job_id"], name: "index_job_tradesmen_applications_on_job_id"
    t.index ["tradesmen_profile_id"], name: "index_job_tradesmen_applications_on_tradesmen_profile_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tradesmen_profile_id"
    t.string "status"
    t.boolean "active"
    t.integer "job_tradesmen_application_id"
    t.boolean "quote_required"
    t.boolean "status_been_started"
    t.boolean "status_been_completed"
    t.string "address_house_street"
    t.string "address_city_town"
    t.string "address_province_state"
    t.string "address_post_code"
    t.date "posted"
    t.date "completed"
    t.index ["business_id"], name: "index_jobs_on_business_id"
    t.index ["job_tradesmen_application_id"], name: "index_jobs_on_job_tradesmen_application_id"
    t.index ["tradesmen_profile_id"], name: "index_jobs_on_tradesmen_profile_id"
  end

  create_table "notification_preferences", force: :cascade do |t|
    t.integer "user_id"
    t.string "category"
    t.string "type_"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_notification_preferences_on_category"
    t.index ["type_"], name: "index_notification_preferences_on_type_"
    t.index ["user_id"], name: "index_notification_preferences_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "body"
    t.string "type_type"
    t.string "type_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "read"
    t.datetime "datetime"
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.string "phone"
    t.string "phone2"
    t.string "email"
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
    t.string "phone"
    t.integer "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "notification_subscription"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "businesses", "users", column: "owner_id", on_delete: :cascade
  add_foreign_key "businesses_tradesmen_profiles", "businesses"
  add_foreign_key "businesses_tradesmen_profiles", "tradesmen_profiles"
  add_foreign_key "job_tradesmen_applications", "jobs", on_delete: :cascade
  add_foreign_key "job_tradesmen_applications", "tradesmen_profiles"
  add_foreign_key "jobs", "businesses"
  add_foreign_key "jobs", "job_tradesmen_applications", on_delete: :cascade
  add_foreign_key "notifications", "users", on_delete: :cascade
  add_foreign_key "tradesmen_profile_users", "roles"
  add_foreign_key "tradesmen_profile_users", "tradesmen_profiles"
  add_foreign_key "tradesmen_profile_users", "users", on_delete: :cascade
  add_foreign_key "tradesmen_profiles", "users", column: "owner_id", on_delete: :cascade
  add_foreign_key "users", "roles", on_delete: :cascade
end
