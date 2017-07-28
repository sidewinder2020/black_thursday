require './lib/invoice'
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
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inr
  end

end
