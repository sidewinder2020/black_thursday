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

end
