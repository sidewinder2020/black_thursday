require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'se_merchants_methods'
require_relative 'se_items_methods'
require_relative 'se_invoices_methods'
require_relative 'se_invoice_item_methods'
require_relative 'se_customer_methods'
require 'pry'

class SalesEngine
  include SeMerchantsMethods
  include SeItemsMethods
  include SeInvoicesMethods
  include SeInvoiceItemMethods
  include SeCustomerMethods

  attr_reader :files,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def initialize(csv_hash)
      @items = item_repository(csv_hash)
      @merchants = merchant_repository(csv_hash)
      @invoices = invoice_repository(csv_hash)
      @invoice_items = invoice_item_repository(csv_hash)
      @customers = customer_repository(csv_hash)
      @transactions = transaction_repository(csv_hash)
  end

  def customer_repository(csv_hash)
    if csv_hash[:customers]
      CustomerRepository.new(csv_hash[:customers], self)
    end
  end

  def invoice_item_repository(csv_hash)
    if csv_hash[:invoice_items]
      InvoiceItemRepository.new(csv_hash[:invoice_items], self)
    end
  end

  def item_repository(csv_hash)
    if csv_hash[:items]
      ItemRepository.new(csv_hash[:items], self)
    end
  end

  def merchant_repository(csv_hash)
    if csv_hash[:merchants]
      MerchantRepository.new(csv_hash[:merchants], self)
    end
  end

  def invoice_repository(csv_hash)
    if csv_hash[:invoices]
      InvoiceRepository.new(csv_hash[:invoices], self)
    end
  end

  def transaction_repository(csv_hash)
    if csv_hash[:transactions]
      TransactionRepository.new(csv_hash[:transactions], self)
    end
  end

  def find_all_items_by_invoice_id(invoice_id)
    item_array = []
    invoice_item_array = @invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item_array.each do |invoice_item|
      item_array << @items.find_by_id(invoice_item.item_id)
    end
    item_array
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

end
