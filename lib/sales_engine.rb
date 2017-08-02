require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative './se_modules/se_merchants_methods'
require_relative './se_modules/se_items_methods'
require_relative './se_modules/se_invoices_methods'
require_relative './se_modules/se_invoice_item_methods'
require_relative './se_modules/se_customer_methods'
require_relative './se_modules/se_transaction_methods'
require_relative './se_modules/se_repositories'

class SalesEngine
  include SeMerchantsMethods
  include SeItemsMethods
  include SeInvoicesMethods
  include SeInvoiceItemMethods
  include SeCustomerMethods
  include SeTransactionMethods
  include SeRepositories

  attr_reader :files,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

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
end
