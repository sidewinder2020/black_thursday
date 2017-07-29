require_relative 'customer'
require 'time'

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

  def find_by_id(customer_id)
    @customers.find do |customer|
      customer.id == customer_id
    end
  end

  def find_all_by_first_name(first_name_fragment, found_customers = [])
    @customers.each do |customer|
      if customer.first_name.include?(first_name_fragment)
        found_customers << customer
      end
    end
    found_customers
  end

  def find_all_by_last_name(last_name_fragment, found_customers = [])
    @customers.each do |customer|
      if customer.last_name.include?(last_name_fragment)
        found_customers << customer
      end
    end
    found_customers
  end

end
