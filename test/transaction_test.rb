require './lib/transaction'
require './lib/transaction_repository'
require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    :transactions => "./test/test_data/transactions_short.csv"
    })
    @tr = TransactionRepository.new("./test/test_data/transactions_short.csv", @se)
    @transaction = Transaction.new({:id => 1,
                                    :invoice_id => 2179,
                                    :credit_card_number => 4068631943231473,
                                    :credit_card_expiration_date => 0217,
                                    :result => 'success',
                                    :created_at => '2012-02-26 20:56:56 UTC',
                                    :updated_at => '2012-02-26 20:56:56 UTC'}, @tr)
  end

  def test_it_has_attributes
    assert_equal 1, @transaction.id
    assert_equal 2179, @transaction.invoice_id
    assert_equal 4068631943231473, @transaction.credit_card_number
    assert_equal 0217, @transaction.credit_card_expiration_date
    assert_equal 'success', @transaction.result
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), @transaction.created_at
    assert_equal Time.parse('2012-02-26 20:56:56 UTC'), @transaction.updated_at
  end

#
# id - returns the integer id
# invoice_id - returns the invoice id
# credit_card_number - returns the credit card number
# credit_card_expiration_date - returns the credit card expiration date
# result - the transaction result
# created_at - returns a Time instance for the date the transaction was first created
# updated_at - returns a Time instance for the date the transaction was last modified

end
