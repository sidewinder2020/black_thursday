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
    @customers = CustomerRepository.new("./test/test_data/customers_short.csv", @se)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customers
  end

  def test_it_returns_all
    assert_equal 51, @customers.all.count
  end

  def test_find_customer_with_customer_id
    assert_instance_of Customer, @customers.find_by_id(5)
    assert_nil @customers.find_by_id(666666666666666)
  end

  def test_find_all_customers_by_first_name
    assert_equal 2, @customers.find_all_by_first_name("Jo").count
    assert_equal [], @customers.find_all_by_first_name("Cornholio")
  end

  def test_find_all_customers_by_last_name
    assert_equal 8, @customers.find_all_by_last_name("On").count
    assert_equal [], @customers.find_all_by_last_name("Cornholio")
  end
end
