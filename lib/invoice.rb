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
    @status = convert_status_to_int(invoice_hash[:status])
    @created_at = Time.parse(invoice_hash[:created_at])
    @updated_at = Time.parse(invoice_hash[:updated_at])
    @inr = inr
  end

  def convert_status_to_int(status)
    if status == "pending"
      return 1
    elsif status == "shipped"
      return 2
    elsif status == "returned"
      return 3
    end
  end

end
