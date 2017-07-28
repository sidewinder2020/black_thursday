require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      })
  end

  def test_load_item_from_item_csv
    assert_instance_of ItemRepository, @se.items
  end

  def test_load_merchants_from_merchant_csv
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_find_all_items_by_merchant_id
    assert_instance_of Item, @se.find_all_by_merchant_id(12334149).first
  end

  def test_find_all_merchant_items_count
    assert_equal 1, @se.merchant_items_count(12334149)
  end
end
