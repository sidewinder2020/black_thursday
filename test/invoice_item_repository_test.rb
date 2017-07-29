require './lib/sales_engine'
require './lib/invoice_item_repository'
require './lib/invoice_item'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceItemTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                                :invoices => "./test/test_data/invoices_short.csv",
                                :invoice_items => "./test/test_data/invoice_items_short.csv",
                                :items => "./data/items.csv"
                                })
    @ivitr = InvoiceItemRepository.new("./test/test_data/invoice_items_short.csv", @se)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @ivitr
  end

  def test_merchants_all
    assert_equal 38, @ivitr.all.count
  end

end
