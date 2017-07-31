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

  def merchants
    invoices.map do |invoice|
      invoice.merchant
    end
  end
end
