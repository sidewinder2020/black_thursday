require './lib/sales_engine'
require './lib/invoice_item_repository'
require './lib/invoice_item'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test

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
    assert_equal 47, @ivitr.all.count
  end

  def test_find_invoice_by_invoice_id
    assert_instance_of InvoiceItem, @ivitr.find_by_id(5)
    assert_nil @ivitr.find_by_id(69)
  end

  def test_find_all_by_item_id
    assert_equal 1, @ivitr.find_all_by_item_id(263519844).count
    assert_equal [], @ivitr.find_all_by_item_id(666420)
  end

  def test_find_all_by_invoice_id
    assert_equal 8, @ivitr.find_all_by_invoice_id(1).count
    assert_equal [], @ivitr.find_all_by_invoice_id(6666666666666)
  end

end
