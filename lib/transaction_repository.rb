require_relative 'transaction'

class InvoiceItemRepository
  attr_reader :transactions

  def initialize(filepath, sales_engine)
    @transactions = []
    @se = sales_engine
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol,
     converters: :numeric) do |row|
      @transactions << Transactions.new(row.to_h, self)
    end
  end

  def all
    @transactions
  end
