require './lib/transaction'
require './lib/transaction_repository'
require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :invoices => "./test/test_data/transactions_short.csv"
    })
    @tr = TransactionRepository.new("./data/merchants.csv", @se)
  end

  def test_all_known_transactions
    assert_equal 50, @tr.all.count
  end
end


# all - returns an array of all known Transaction instances
# find_by_id - returns either nil or an instance of Transaction with a matching ID
# find_all_by_invoice_id - returns either [] or one or morematches which have a matching invoice ID
# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status
