module SeInvoiceItemMethods
  def find_all_items_by_invoice_id(invoice_id)
    item_array = []
    invoice_item_array = @invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item_array.each do |invoice_item|
      item_array << @items.find_by_id(invoice_item.item_id)
    end
    item_array
  end

  def get_invoice_items_by_invoice_id(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id)
  end
end
