require "test_helper"

class StockItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_item = stock_items(:one)
  end

  test "should get index" do
    get stock_items_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_item_url
    assert_response :success
  end

  test "should create stock_item" do
    assert_difference("StockItem.count") do
      post stock_items_url, params: { stock_item: { product_id: @stock_item.product_id, quantity: @stock_item.quantity, size_id: @stock_item.size_id, stock_id: @stock_item.stock_id } }
    end

    assert_redirected_to stock_item_url(StockItem.last)
  end

  test "should show stock_item" do
    get stock_item_url(@stock_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_item_url(@stock_item)
    assert_response :success
  end

  test "should update stock_item" do
    patch stock_item_url(@stock_item), params: { stock_item: { product_id: @stock_item.product_id, quantity: @stock_item.quantity, size_id: @stock_item.size_id, stock_id: @stock_item.stock_id } }
    assert_redirected_to stock_item_url(@stock_item)
  end

  test "should destroy stock_item" do
    assert_difference("StockItem.count", -1) do
      delete stock_item_url(@stock_item)
    end

    assert_redirected_to stock_items_url
  end
end
