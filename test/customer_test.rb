require './lib/customer'
require './lib/sales_engine'
require './lib/customer_repository'
require 'time'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class CustomerTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                                :customers => "./test/test_data/customers_short.csv",
                                })
    @customers = CustomerRepository.new("./test/test_data/customers_short.csv", @se)
  end

  def test_it_exists
    assert_instance_of Customer, @customers
  end

end
