class MakeJobTradesmenApplicationForeignKeyOptionalFix < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :jobs, :job_tradesmen_applications
    add_foreign_key :jobs, :job_tradesmen_applications, on_delete: :cascade
  end
end
