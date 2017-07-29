require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'date'
require 'pry'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def merchants_total_inventory
    @se.get_merchants_total_inventory
  end

  def average_items_per_merchant
    find_avrg_of_array(merchants_total_inventory)
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
    deviant_number =
    (deviant_array.reduce(:+)) / ((deviant_array.length - 1).to_f)
    (Math.sqrt(deviant_number)).round(2)
  end

  #stay
  def average_items_per_merchant_standard_deviation
    find_standard_deviation(merchants_total_inventory)
  end

  def find_inventory_total_one_std_deviation_above_avrg
    std_dev = find_standard_deviation(merchants_total_inventory)
    mean = find_avrg_of_array(merchants_total_inventory)
    outlier_threshhold = std_dev + mean
    outlier_threshhold
  end

  def merchants_with_high_item_count
    outliers = find_inventory_total_one_std_deviation_above_avrg
    @se.return_merchants_by_item_count_greater_than(outliers)
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices = @se.get_item_prices_by_merchant_id(merchant_id)
    find_avrg_of_array(item_prices)
  end

  def average_average_price_per_merchant(avrg_avrg_array = [])
    @se.all_merchant_ids.each do |merchant|
      avrg_avrg_array << average_item_price_for_merchant(merchant)
    end
    find_avrg_of_array(avrg_avrg_array)
  end

  def array_of_item_prices(price_array = [])
    @se.all_items.each do |item|
      price_array << item.unit_price
    end
    price_array
  end

  def golden_items
    price_array = array_of_item_prices
    avrg = find_avrg_of_array(price_array)
    std_dev = find_standard_deviation(price_array)
    golden_array = []
    @se.all_items.each do |item|
      if item.unit_price >= std_dev*2 + avrg
        golden_array << item
      end
    end
      golden_array
  end

  def average_invoices_per_merchant
    find_avrg_of_array(@se.average_invoices_per_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    find_standard_deviation(@se.average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    top_merchant_object_array = []
    top_merchants_array = get_top_merchants_array_by_invoice
    top_merchants_array.each do |merchant_id|
      top_merchant_object_array << @se.get_merchant_by_id(merchant_id)
    end
    top_merchant_object_array
  end

  def get_top_merchants_array_by_invoice
    top_merchants_array = []
    top_merchants_hash = @se.get_count_by_merchant_id
    mean = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation * 2
    top_merchants_hash.each do |key,value|
      if value > standard_deviation + mean
        top_merchants_array << key
      end
    end
    top_merchants_array
  end

  def get_bottom_merchants_array_by_invoice_count
    bottom_merchants_array = []
    bottom_merchants_hash = @se.get_count_by_merchant_id
    mean = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation * 2
    bottom_merchants_hash.each do |key,value|
      if value < standard_deviation + mean
        bottom_merchants_array << key
      end
    end
    bottom_merchants_array
  end

  def bottom_merchants_by_invoice_count
    bottom_merchant_object_array = []
    bottom_merchants_array = get_bottom_merchants_array_by_invoice_count
    bottom_merchants_array.each do |merchant_id|
      bottom_merchant_object_array << @se.get_merchant_by_id(merchant_id)
    end
    bottom_merchant_object_array
  end

  def get_top_days_by_invoice_count
    top_days_of_the_week_array = []
    top_days_of_the_week_hash = @se.get_number_of_invoices_by_day_of_the_week
    mean = average_invoices_per_day
    standard_deviation =
    average_invoices_per_day_of_the_week_standard_deviation
    top_days_of_the_week_hash.each do |key,value|
      if value > standard_deviation + mean
        top_days_of_the_week_array << key
      end
    end
    top_days_of_the_week_array
  end

  def top_days_by_invoice_count
    get_top_days_by_invoice_count.map do |weekday|
      Date::DAYNAMES[weekday]
    end
  end

  def average_invoices_per_day
    find_avrg_of_array(@se.get_number_of_invoices_by_day)
  end

  def average_invoices_per_day_of_the_week_standard_deviation
    find_standard_deviation(@se.get_number_of_invoices_by_day)
  end

  def invoice_status(status)
    ((@se.number_of_invoices_by_status[status].to_f /
    @se.all_invoices_count) * 100).round(2)
  end

end
