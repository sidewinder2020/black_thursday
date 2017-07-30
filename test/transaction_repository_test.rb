require './lib/transaction'
require './lib/transaction_repository'
require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :transactions => "./test/test_data/transactions_short.csv"
    })
    @tr = TransactionRepository.new("./test/test_data/transactions_short.csv", @se)
  end

  def test_all_known_transactions
    assert_equal 50, @tr.all.count
  end

  def test_find_by_id
    assert_instance_of Transaction, @tr.find_by_id(5)
  end

  def test_find_all_by_invoice_id
    assert_equal 1, @tr.find_all_by_invoice_id(2179).count
  end

  def test_all_by_credit_card_number
    assert_equal 1, @tr.find_all_by_credit_card_number(4257133712179878).count
  end

  def test_find_all_by_result
    assert_equal 40, @tr.find_all_by_result('success').count
  end
end
