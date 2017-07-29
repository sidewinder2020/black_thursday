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
    @invitem = InvoiceItem.new({:id => 1,
                                :item_id => 263519844,
                                :invoice_id => 1,
                                :quantity => 5,
                                :unit_price => 13635,
                                :created_at => "2012-03-27 14:54:09 UTC",
                                :updated_at => "2012-03-27 14:54:09 UTC"}, @ivitr)
  end

  def test_it_exists
    binding.pry
    assert_instance_of InvoiceItem, @invitem
  end

  def test_it_has_attributes
    assert_equal 1, @invitem.id
    assert_equal 263519844, @invitem.item_id
    assert_equal 1, @invitem.invoice_id
    assert_equal 5, @invitem.quantity
    assert_equal 13635, @invitem.unit_price
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invitem.created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invitem.updated_at
  end
end
