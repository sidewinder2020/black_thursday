require_relative 'invoice'
require 'pry'

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

  def find_merchant_by_merchant_id(merchant_id)
    @se.get_merchant_by_id(merchant_id)
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

  def find_all_invoice_merchant_id
    @invoices.map do |invoice|
      invoice.merchant_id
    end
  end

  def get_count_by_merchant_id
    merchant_ids = find_all_invoice_merchant_id
    counts = Hash.new(0)
    merchant_ids.each do |merchant_id|
      counts[merchant_id] += 1
    end
    counts
  end

  def average_invoices_per_merchant
    counts = get_count_by_merchant_id
    merchant_id_count_array = []
    counts.each_value do |number|
      merchant_id_count_array << number
    end
    merchant_id_count_array
  end

  def get_invoice_count_by_day_of_week
    weekday_counts = find_all_invoice_days_of_the_week
    counts = Hash.new(0)
    weekday_counts.each do |weekday|
      counts[weekday] += 1
    end
    counts
  end

  def get_number_of_invoices_by_day
    counts_by_day = []
    get_invoice_count_by_day_of_week.each_value do |day|
      counts_by_day << day
    end
    counts_by_day
  end

  def find_all_invoice_days_of_the_week
    @invoices.map do |invoice|
      invoice.created_at.wday
    end
  end

  def number_of_invoices_by_status
    status_hash = Hash.new
    status_hash[:pending] = find_all_by_status(:pending).count
    status_hash[:shipped] = find_all_by_status(:shipped).count
    status_hash[:returned] = find_all_by_status(:returned).count
    status_hash
  end

  def get_all_invoices_by_merchant_id(merchant_id)
    new_array = []
    @invoices.each do |invoice|
      if invoice.merchant_id == merchant_id
        new_array << invoice
      end
    end
    new_array
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end


end
