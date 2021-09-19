class DeleteForeignKeysWhenUserDeleted < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key "businesses", "users", column: "owner_id"
    remove_foreign_key "notifications", "users"
    remove_foreign_key "tradesmen_profile_users", "users"
    remove_foreign_key "tradesmen_profiles", "users", column: "owner_id"
    remove_foreign_key "users", "roles"

    add_foreign_key "businesses", "users", column: "owner_id", on_delete: :cascade
    add_foreign_key "notifications", "users", on_delete: :cascade
    add_foreign_key "tradesmen_profile_users", "users", on_delete: :cascade
    add_foreign_key "tradesmen_profiles", "users", column: "owner_id", on_delete: :cascade
    add_foreign_key "users", "roles", on_delete: :cascade
  end
end
