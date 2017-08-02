require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(filepath, sales_engine)
    @transactions = []
    @se = sales_engine
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol,
     converters: :numeric) do |row|
      @transactions << Transaction.new(row.to_h, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(transaction_id)
    @transactions.find do |transaction|
      transaction.id == transaction_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == cc_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_id(invoice_id)
    @se.find_by_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
