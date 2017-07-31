require 'time'

class Customer
attr_reader :id,
            :first_name,
            :last_name,
            :created_at,
            :updated_at

  def initialize(customer_hash, customers)
    @customers = customers
    @id = customer_hash[:id]
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at = Time.parse(customer_hash[:created_at])
    @updated_at = Time.parse(customer_hash[:updated_at])
  end

  def invoices
    @customers.get_all_invoices_by_customer_id(@id)
  end

  def get_total_spent(total_spent = 0)
    invoices.each do |invoice|
      if invoice.is_paid_in_full?
        total_spent += invoice.total
      end
    end
    total_spent.to_i
  end

  def merchants
    invoices.map do |invoice|
      invoice.merchant
    end
  end
end
