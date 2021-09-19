class MakeJobTradesmenApplicationForeignKeyOptional < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :job_tradesmen_applications, :jobs
    add_foreign_key :job_tradesmen_applications, :jobs, on_delete: :cascade
  end
end
