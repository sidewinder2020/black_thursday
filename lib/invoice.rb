require 'time'

class Invoice
attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at

  def initialize(invoice_hash, inr)
    @id = invoice_hash[:id]
    @customer_id = invoice_hash[:customer_id]
    @merchant_id = invoice_hash[:merchant_id]
    @status = invoice_hash[:status].to_sym
    @created_at = Time.parse(invoice_hash[:created_at])
    @updated_at = Time.parse(invoice_hash[:updated_at])
    @inr = inr
  end

  def merchant
    @inr.find_merchant_by_merchant_id(@merchant_id)
  end

  def items
    @inr.find_all_items_by_invoice_id(@id)
  end

  def transactions
    @inr.find_all_transactions_by_invoice_id(@id)
  end

  def customer
    @inr.get_customer_by_customer_id(@customer_id)
  end

end
