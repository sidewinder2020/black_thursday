require './lib/invoice'
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/invoice_item'
require 'bigdecimal'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                                :invoices => "./test/test_data/invoices_short.csv",
                                :merchants => "./data/merchants.csv",
                                :items => "./data/items.csv",
                                :invoice_items => "./test/test_data/invoice_items_short.csv",
                                :transactions => "./test/test_data/transactions_short.csv",
                                :customers => "./test/test_data/customers_short.csv"
                                })
    @inr = InvoiceRepository.new("./test/test_data/invoices_short.csv", @se)
    @invoice = Invoice.new({
                      :id          => 6,
                      :customer_id => 7,
                      :merchant_id => 12335938,
                      :status      => "pending",
                      :created_at  => "2014-04-13",
                      :updated_at  => "2015-01-20",
                      }, @inr)
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_all_attributes
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 12335938, @invoice.merchant_id
    assert_equal :pending, @invoice.status
    assert_equal Time.parse("2014-04-13"), @invoice.created_at
    assert_equal Time.parse("2015-01-20"), @invoice.updated_at
  end

  def test_find_merchant_by_merchant_id
    assert_instance_of Merchant, @invoice.merchant
  end

  def test_invoice_items_returns_array_of_items_with_matching_invoice_id
    assert_equal 7, @invoice.items.count
  end

  def test_invoice_retrieves_transactions
    assert_equal 1, @invoice.transactions.count
  end

  def test_invoice_retrieves_customers
    assert_instance_of Customer, @invoice.customer
  end

  def test_invoice_items_returns_array_of_invoice_items_with_matching_invoice_id
    assert_equal 7, @invoice.invoice_items.count
  end

  def test_is_paid_in_full_returns_true
    assert @invoice.is_paid_in_full?
  end

  def test_can_grab_total_cost_of_items
    assert_instance_of BigDecimal, @invoice.total
  end

  def test_it_can_return_total_quantity_of_items
    assert_equal 17, @invoice.quantity_of_items
  end
end
