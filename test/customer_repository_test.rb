require './lib/sales_engine'
require './lib/customer_repository'
require './lib/customer'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                                :customers => "./test/test_data/customers_short.csv",
                                })
    @customers = CustomerRepository.new("./test/test_data/invoice_items_short.csv", @se)
  end
end
