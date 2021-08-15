class AddQuoteToJobTradesmenApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :job_tradesmen_applications, :quote, :string
  end
end
