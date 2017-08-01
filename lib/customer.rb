require 'time'
require 'pry'

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

  def top_number_of_items_sold_by_invoice(invoices = @invoices)
    invoices.max_by do |invoice|
      invoice.quantity_of_items
    end
    if invoice.is_paid_in_full?
      return invoice
    else
      top_invoices = invoices
      top_invoices -= invoice
      top_number_of_items_sold_by_invoice(top_invoices)
    end
  end

  def top_merchant_for_customer
    top_number_of_items_sold_by_invoice.merchant_id
  end

end
