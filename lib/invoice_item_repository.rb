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
# find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
# find_all_by_item_id - returns either [] or one or more matches which have a matching item ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
end
