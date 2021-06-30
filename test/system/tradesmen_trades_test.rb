require "application_system_test_case"

class TradesmenTradesTest < ApplicationSystemTestCase
  setup do
    @tradesmen_trade = tradesmen_trades(:one)
  end

  test "visiting the index" do
    visit tradesmen_trades_url
    assert_selector "h1", text: "Tradesmen Trades"
  end

  test "creating a Tradesmen trade" do
    visit tradesmen_trades_url
    click_on "New Tradesmen Trade"

    fill_in "Name", with: @tradesmen_trade.name
    click_on "Create Tradesmen trade"

    assert_text "Tradesmen trade was successfully created"
    click_on "Back"
  end

  test "updating a Tradesmen trade" do
    visit tradesmen_trades_url
    click_on "Edit", match: :first

    fill_in "Name", with: @tradesmen_trade.name
    click_on "Update Tradesmen trade"

    assert_text "Tradesmen trade was successfully updated"
    click_on "Back"
  end

  test "destroying a Tradesmen trade" do
    visit tradesmen_trades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tradesmen trade was successfully destroyed"
  end
end
