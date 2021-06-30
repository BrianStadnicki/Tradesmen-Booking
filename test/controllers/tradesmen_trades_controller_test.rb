require "test_helper"

class TradesmenTradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tradesmen_trade = tradesmen_trades(:one)
  end

  test "should get index" do
    get tradesmen_trades_url
    assert_response :success
  end

  test "should get new" do
    get new_tradesmen_trade_url
    assert_response :success
  end

  test "should create tradesmen_trade" do
    assert_difference('TradesmenTrade.count') do
      post tradesmen_trades_url, params: { tradesmen_trade: { name: @tradesmen_trade.name } }
    end

    assert_redirected_to tradesmen_trade_url(TradesmenTrade.last)
  end

  test "should show tradesmen_trade" do
    get tradesmen_trade_url(@tradesmen_trade)
    assert_response :success
  end

  test "should get edit" do
    get edit_tradesmen_trade_url(@tradesmen_trade)
    assert_response :success
  end

  test "should update tradesmen_trade" do
    patch tradesmen_trade_url(@tradesmen_trade), params: { tradesmen_trade: { name: @tradesmen_trade.name } }
    assert_redirected_to tradesmen_trade_url(@tradesmen_trade)
  end

  test "should destroy tradesmen_trade" do
    assert_difference('TradesmenTrade.count', -1) do
      delete tradesmen_trade_url(@tradesmen_trade)
    end

    assert_redirected_to tradesmen_trades_url
  end
end
