class JobTradesmenApplicationUseDecimalQuote < ActiveRecord::Migration[6.1]
  def change
    change_column :job_tradesmen_applications, :quote, :decimal, precision: 8, scale: 2
  end
end
