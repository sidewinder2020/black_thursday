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

  def get_total_inventory
    total_inventory_array = []
    @se.merchants.all_ids.each do |id|
      total_inventory_array << merchant_items_count(id)
    end
    total_inventory_array
  end

  def find_avrg_of_array(array)
    (array.reduce(:+) / array.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    deviant_array = []
    total = get_total_inventory
    mean = find_avrg_of_array(total)
    total.each do |number|
       deviant_array << (mean - number)**2
     end
    deviant_number = (deviant_array.reduce(:+)) / ((deviant_array.length - 1).to_f)
    (Math.sqrt(deviant_number)).round(2)
  end

end
