require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_retrieve_number_of_items_for_one_merchant
    item_count = @sa.merchant_items_count(12334105)

    assert_equal 3, item_count
  end

  def test_find_avrg_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_find_avrg_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_for_merchants_with_item_count_1_above_std_deviation
    assert_equal 52, @sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_equal 3150.0, @sa.average_item_price_for_merchant(12334159)
    assert_equal 1683.33, @sa.average_item_price_for_merchant(12334372)
    assert_equal 3000.0, @sa.average_item_price_for_merchant(12335722)
    assert_equal 2000.0, @sa.average_item_price_for_merchant(12336683)
  end

  def test_the_average_average_price_per_merchant
    assert_equal 35029.47, @sa.average_average_price_per_merchant
  end

  def test_for_golden_items_two_std_dev_above_avrg
    assert_equal 5, @sa.golden_items.count
  end

end
