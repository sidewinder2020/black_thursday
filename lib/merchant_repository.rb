require 'simplecov'
SimpleCov.start
require 'CSV'

class MerchantRepository

  attr_reader :merchants

  def initialize(filepath, sales_engine)
    @merchants = []
    @se = sales_engine
    load_csv(filepath)
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol,
     converters: :numeric) do |row|
      @merchants << Merchant.new(row.to_h, @se)
    end
  end

  def all
    @merchants
  end

  def all_ids
    id_array = []
    @merchants.each do |merchant|
      id_array << merchant.id
    end
    id_array
  end

  def find_by_id(merchant_id, found_merchant = '')
    @merchants.each do |merchant|
      if merchant.id == merchant_id
        found_merchant = merchant
        break
      else
        found_merchant = nil
      end
    end
    found_merchant
  end

  def find_by_name(merchant_name, found_merchant = '')
    @merchants.each do |merchant|
      if merchant.name.upcase == merchant_name.upcase
        found_merchant = merchant
        break
      else
        found_merchant = nil
      end
    end
    found_merchant
  end

  def find_all_by_name(name_fragment, found_merchants = [])
    @merchants.each do |merchant|
      if merchant.name.upcase.include?(name_fragment.upcase)
        found_merchants << merchant
      end
    end
    found_merchants
  end

  def get_total_inventory
    total_inventory_array = []
    @merchants.each do |merchant|
      total_inventory_array << merchant_items_count(merchant.id)
    end
    total_inventory_array
  end

  def merchant_items_count(merchant_id)
    array = @se.items.find_all_by_merchant_id(merchant_id)
    array.length
  end

  def return_merchants_by_item_count_greater_than(condition, results = [])
    @merchants.each do |merchant|
      if merchant.items.count > condition
        results << merchant
      end
    end
    results
  end
end
