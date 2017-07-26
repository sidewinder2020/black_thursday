require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_retrieve_number_of_items_for_one_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    item_count = sa.merchant_items_count(12334105)

    assert_equal 3, item_count
  end

  def test_find_avrg_items_per_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_find_avrg_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

end
