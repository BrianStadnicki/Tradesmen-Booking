class AddAcceptedTradesmenToJob < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :job_tradesmen_application, foreign_key: true
  end
end
