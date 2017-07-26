require 'pry'
require './lib/sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def merchant_items_count(merchant_id)
    array = @se.items.find_all_by_merchant_id(merchant_id)
    array.length
  end

  def average_items_per_merchant
    find_avrg_of_array(get_total_inventory)
  end

  def find_avrg_of_array(array)
    (array.reduce(:+) / array.length.to_f).round(2)
  end

  def find_standard_deviation(array)
    deviant_array = []
    mean = find_avrg_of_array(array)
    array.each do |number|
      deviant_array << (mean - number)**2
    end
    deviant_number = (deviant_array.reduce(:+)) / ((deviant_array.length - 1).to_f)
    (Math.sqrt(deviant_number)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    total = get_total_inventory
    find_standard_deviation(total)
  end

  def get_total_inventory
    total_inventory_array = []
    @se.merchants.all_ids.each do |id|
      total_inventory_array << merchant_items_count(id)
    end
    total_inventory_array
  end

  def find_inventory_total_one_std_deviation_above_avrg_std_deviation
    total = get_total_inventory
    std_dev = find_standard_deviation(total)
    mean = find_avrg_of_array(total)
    outlier_threshhold = std_dev + mean
    outlier_threshhold
  end

  def merchants_with_high_item_count
    deviant_merchants = []
    outlier_threshhold = find_inventory_total_one_std_deviation_above_avrg_std_deviation
    @se.merchants.all.each do |merchant|
      if merchant.items.count > outlier_threshhold
        deviant_merchants << merchant
      end
    end
    deviant_merchants
  end

  #sa.average_item_price_for_merchant(12334159)

end
