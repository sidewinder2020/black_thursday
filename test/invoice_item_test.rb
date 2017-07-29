require './lib/invoice_item'
require './lib/sales_engine'
require './lib/invoice_item_repository'
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
    assert_instance_of InvoiceItem, @ivitr
  end

  def test_it_has_attributes
    assert_equal 1, @ivitr.all.first.id
    assert_equal 263519844, @ivitr.all.first.item_id
    assert_equal 1, @ivitr.all.first.invoice_id
    assert_equal 5, @ivitr.all.first.quantity
    assert_equal 13635, @ivitr.all.first.unit_price
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @ivitr.all.first.created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @ivitr.all.first.updated_at
  end
end
