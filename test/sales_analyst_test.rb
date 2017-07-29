require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./test/test_data/invoices_short.csv",
    })
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
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
    assert_equal 31.5, @sa.average_item_price_for_merchant(12334159)
    assert_equal 16.83, @sa.average_item_price_for_merchant(12334372)
    assert_equal 30.00, @sa.average_item_price_for_merchant(12335722)
    assert_equal 20.00, @sa.average_item_price_for_merchant(12336683)
  end

  def test_the_average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_for_golden_items_two_std_dev_above_avrg
    assert_equal 5, @sa.golden_items.count
  end

  def test_average_invoices_per_merchant
    assert_equal 1.07, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_retrieve_top_merchants_by_invoice_id
    assert_equal 2, @sa.top_merchants_by_invoice_count.count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count[0]
  end

  def test_retrieve_bottom_merchants_by_invoice_id
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
    assert_instance_of Merchant, @sa.bottom_merchants_by_invoice_count[0]
  end

  def test_retrieve_top_days_of_the_week_by_invoice
    assert_equal 1, @sa.top_days_by_invoice_count.count
    assert_equal "Friday" , @sa.top_days_by_invoice_count[0]
  end

  def test_retrieve_percentage_of_invoice_statuses
    assert_equal 34.48, @sa.invoice_status(:pending)
    assert_equal 62.07, @sa.invoice_status(:shipped)
    assert_equal 3.45, @sa.invoice_status(:returned)
  end

end
