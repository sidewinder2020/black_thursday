require './lib/invoice'
require './lib/sales_engine'
require './lib/invoice_repository'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices => "./data/invoices.csv",
                                })
    @inr = InvoiceRepository.new("./data/invoices.csv", @se)
    @invoice = Invoice.new({
                      :id          => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
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
    assert_equal 8, @invoice.merchant_id
    assert_equal "pending", @invoice.status
    assert_equal Time.parse("2014-04-13"), @invoice.created_at
    assert_equal Time.parse("2015-01-20"), @invoice.updated_at
  end
  
end
