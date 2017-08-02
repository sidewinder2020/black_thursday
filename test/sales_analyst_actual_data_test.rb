require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class SalesAnalystActualDataTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"
    })
    @sa = SalesAnalyst.new(@se)
  end

  def test_find_10_most_wanted
    assert_equal 10, @sa.ten_most_wanted.count
    assert_instance_of Hash, @sa.ten_most_wanted
  end
end
