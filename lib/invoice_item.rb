require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item_hash, ivitr)
    @ivitr = ivitr
    @invoice_item_hash = invoice_item_hash
    @id = invoice_item_hash[:id]
    @item_id = invoice_item_hash[:item_id]
    @invoice_id = invoice_item_hash[:invoice_id]
    @quantity = invoice_item_hash[:quantity]
    @unit_price = invoice_item_hash[:unit_price]
    @created_at = Time.parse(invoice_item_hash[:created_at])
    @updated_at = Time.parse(invoice_item_hash[:updated_at])
  end

# unit_price_to_dollars - returns the price of the invoice item in dollars formatted as a Float
end
