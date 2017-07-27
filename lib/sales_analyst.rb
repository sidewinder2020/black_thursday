require 'pry'
require './lib/sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def merchants_total_inventory
    @se.merchants.get_total_inventory
  end

  #stay
  def average_items_per_merchant
    find_avrg_of_array(merchants_total_inventory)
  end

  #stay
  def find_avrg_of_array(array)
    (array.reduce(:+) / array.length.to_f).round(2)
  end

  #stay
  def find_standard_deviation(array)
    deviant_array = []
    mean = find_avrg_of_array(array)
    array.each do |number|
      deviant_array << (mean - number)**2
    end
    deviant_number = (deviant_array.reduce(:+)) / ((deviant_array.length - 1).to_f)
    (Math.sqrt(deviant_number)).round(2)
  end

  #stay
  def average_items_per_merchant_standard_deviation
    find_standard_deviation(merchants_total_inventory)
  end

  #stay
  def find_inventory_total_one_std_deviation_above_avrg_std_deviation
    std_dev = find_standard_deviation(merchants_total_inventory)
    mean = find_avrg_of_array(merchants_total_inventory)
    outlier_threshhold = std_dev + mean
    outlier_threshhold
  end

  #stay
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

  #live in items
  def get_item_prices_by_merchant_id(merchant_id, item_prices = [])
    items = @se.items.find_all_by_merchant_id(merchant_id)
      items.each do |item|
        item_prices << item.unit_price
      end
      item_prices
  end

  #live in items
  def average_item_price_for_merchant(merchant_id)
    item_prices = get_item_prices_by_merchant_id(merchant_id)
    find_avrg_of_array(item_prices)
  end

  #live in merchants
  def average_average_price_per_merchant(avrg_avrg_array = [])
    @se.merchants.all_ids.each do |merchant|
      avrg_avrg_array << average_item_price_for_merchant(merchant)
    end
    find_avrg_of_array(avrg_avrg_array)
  end

  #item repo
  def array_of_item_prices(price_array = [])
    @se.items.all.each do |item|
      price_array << item.unit_price
    end
    price_array
  end

  #call array from item repo
  def golden_items
    price_array = array_of_item_prices
    avrg = find_avrg_of_array(price_array)
    std_dev = find_standard_deviation(price_array)
    golden_array = []
    @se.items.all.each do |item|
      if item.unit_price >= std_dev*2 + avrg
        golden_array << item
      end
    end
      golden_array
  end

end