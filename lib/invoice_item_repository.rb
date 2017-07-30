require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(filepath, sales_engine)
    @invoice_items = []
    @se = sales_engine
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol,
     converters: :numeric) do |row|
      @invoice_items << InvoiceItem.new(row.to_h, self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(invoice_id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == invoice_id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

end
