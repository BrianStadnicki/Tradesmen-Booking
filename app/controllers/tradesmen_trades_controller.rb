class TradesmenTradesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /tradesmen_trades
  def index
  end

  # GET /tradesmen_trades/1
  def show
  end

  # GET /tradesmen_trades/new
  def new
  end

  # GET /tradesmen_trades/1/edit
  def edit
  end

  # POST /tradesmen_trades
  def create
    if @tradesmen_trade.save!
      redirect_to @tradesmen_trade, notice: 'Tradesmen trade was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tradesmen_trades/1
  def update
    if @tradesmen_trade.update(tradesmen_trade_params)
      redirect_to @tradesmen_trade, notice: 'Tradesmen trade was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tradesmen_trades/1
  def destroy
    @tradesmen_trade.destroy
    redirect_to tradesmen_trades_url, notice: 'Tradesmen trade was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def tradesmen_trade_params
    params.require(:tradesmen_trade).permit(:name)
  end
end
