require_relative 'customer'

class CustomerRepository
  attr_reader :customers

  def initialize(filepath, sales_engine)
    @customers = []
    @se = sales_engine
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol,
     converters: :numeric) do |row|
      @customers << Customer.new(row.to_h, self)
    end
  end

  def all
    @customers
  end
end
