class CreateTradesmenTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :tradesmen_trades do |t|
      t.string :name

      t.timestamps
    end
  end
end
