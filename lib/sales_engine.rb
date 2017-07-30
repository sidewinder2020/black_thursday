require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'se_merchants_methods'
require_relative 'se_items_methods'
require_relative 'se_invoices_methods'
require_relative 'se_invoice_item_methods'
require_relative 'se_customer_methods'

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
      TransactionRepository.new(csv_hash[:transaction])
    end
  end
end
