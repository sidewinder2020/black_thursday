require './lib/invoice'
require './lib/invoice_repository'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv",
        })
    @inr = InvoiceRepository.new("./data/invoices.csv", @se)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inr
  end

  def test_all_returns_all_invoices_in_the_correct_format
    assert_equal 4985, @inr.all.count
  end

  def test_find_by_id
    assert_instance_of Invoice, @inr.find_by_id(11)
    assert_nil @inr.find_by_id(1903834)
  end

  def test_find_all_by_customer_id
    assert_equal 10, @inr.find_all_by_customer_id(107).count
    assert_equal [], @inr.find_all_by_customer_id(1238435209)
  end

  def test_find_all_by_merchant_id
    assert_equal 12, @inr.find_all_by_merchant_id(12335955).count
    assert_equal [], @inr.find_all_by_merchant_id(2)
  end

  def test_find_all_by_status
    assert_equal 79, @inr.find_all_by_status("pending")
    # assert_equal [], @inr.find_all_by_status("bonkers")
  end

end
