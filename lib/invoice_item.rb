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
    @invoice_item_hash = invoice_item_hash
    @ivitr = ivitr
    @id = invoice_item_hash[:id]
    @item_id = invoice_item_hash[:item_id]
    @invoice_id = invoice_item_hash[:invoice_id]
    @quantity = invoice_item_hash[:quantity]
    @unit_price = BigDecimal.new(
    invoice_item_hash[:unit_price].to_s.insert(-3, "."))
    @created_at = Time.parse(invoice_item_hash[:created_at])
    @updated_at = Time.parse(invoice_item_hash[:updated_at])
  end

  def unit_price_to_dollars
    (@invoice_item_hash[:unit_price] / 100).to_f
  end

  def total_invoice_price
    @unit_price * @quantity
  end

end
