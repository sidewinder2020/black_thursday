require './lib/invoice'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class InvoiceTest < Minitest::Test

  def setup
    @invoice = Invoice.new({
                      :id          => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status      => "pending",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      })
    end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_all_attributes
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
    assert_equal "pending", @invoice.status
    assert_equal Time.now, @invoice.created_at
    assert_equal Time.now, @invoice.updated_at
  end

end
