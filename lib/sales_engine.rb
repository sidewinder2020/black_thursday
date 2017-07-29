require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :files,
              :items,
              :merchants,
              :invoices

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def initialize(csv_hash)
      @items = item_repository(csv_hash)
      @merchants = merchant_repository(csv_hash)
      @invoices = invoice_repository(csv_hash)
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

  def all_items
    @items.all
  end

  def all_merchant_ids
    @merchants.all_ids
  end

  def all_invoices_count
    @invoices.all.count
  end

  def get_merchants_total_inventory
    @merchants.get_total_inventory
  end

  def get_item_prices_by_merchant_id(merchant_id)
    @items.get_item_prices_by_merchant_id(merchant_id)
  end

  def return_merchants_by_item_count_greater_than(outliers)
    @merchants.return_merchants_by_item_count_greater_than(outliers)
  end

  def merchant_items_count(merchant_id)
    @items.find_all_by_merchant_id(merchant_id).length
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def get_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def average_invoices_per_merchant
    @invoices.average_invoices_per_merchant
  end

  def get_count_by_merchant_id
    @invoices.get_count_by_merchant_id
  end

  def get_number_of_invoices_by_day
    @invoices.get_number_of_invoices_by_day
  end

  def get_number_of_invoices_by_day_of_the_week
    @invoices.get_invoice_count_by_day_of_week
  end

  def number_of_invoices_by_status
    @invoices.number_of_invoices_by_status
  end
end
