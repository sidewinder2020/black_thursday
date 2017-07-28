
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

class SalesEngine
  attr_reader :files,
              :items,
              :merchants,
              :invoices

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def initialize(csv_hash)
      @items = ItemRepository.new(csv_hash[:items], self)
      @merchants = MerchantRepository.new(csv_hash[:merchants], self)
      @invoices = InvoiceRepository.new(csv_hash[:invoices], self)
  end

  def all_items
    @items.all
  end

  def all_merchant_ids
    @merchants.all_ids
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

end
