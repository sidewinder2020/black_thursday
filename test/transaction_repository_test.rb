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


end
