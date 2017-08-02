require './lib/customer'
require './lib/sales_engine'
require './lib/customer_repository'
require './lib/transaction'
require './lib/invoice'
require './lib/invoice_item'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class CustomerTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                                :customers => "./test/test_data/customers_short.csv",
                                :invoices => "./test/test_data/invoices_short.csv",
                                :merchants => "./data/merchants.csv",
                                :transactions => "./test/test_data/transactions_short.csv",
                                :invoice_items => "./test/test_data/invoice_items_short.csv",
                                :items => "./data/items.csv",
                                })
    @customers = CustomerRepository.new("./test/test_data/customers_short.csv", @se)

    @for_realsies_customer = @customers.all[0]
  end

  def test_it_exists
    assert_instance_of Customer, @customers.all[0]
  end

  def test_all_attributes
    assert_equal 1,@for_realsies_customer.id
    assert_equal "Joey",@for_realsies_customer.first_name
    assert_equal "Ondricka",@for_realsies_customer.last_name
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"),@for_realsies_customer.created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"),@for_realsies_customer.updated_at
  end

  def test_is_can_get_invoices
    assert_instance_of Invoice, @for_realsies_customer.invoices.first
  end

  def test_it_can_get_merchants
    assert_instance_of Merchant, @for_realsies_customer.merchants.first
  end

  def test_get_total_price
    assert_equal 25842, @for_realsies_customer.get_total_spent
  end

  def test_we_can_get_merchant_id_for_customer
    assert_equal 12335938, @for_realsies_customer.top_merchant_for_customer
  end

  def test_all_purchased_items_returns_items
    assert_equal 15, @for_realsies_customer.all_purchased_items.count
  end

  def test_find_customer_invoices_by_year_does_thing
    assert_equal 1, @for_realsies_customer.find_customer_invoices_by_year(2009).count
  end
end
