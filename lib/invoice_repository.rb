require_relative 'invoice'

class InvoiceRepository

attr_reader :invoices

  def initialize(filepath, sales_engine)
    @invoices = []
    @se = sales_engine
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true,
                          header_converters: :symbol,
                          converters: :all) do |row|
      @invoices << Invoice.new(row.to_h, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(invoice_id, the_chosen_one = '')
    @invoices.each do |invoice|
      if invoice_id == invoice.id
        the_chosen_one = invoice
      break
      else
        the_chosen_one = nil
      end
    end
    the_chosen_one
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

end
