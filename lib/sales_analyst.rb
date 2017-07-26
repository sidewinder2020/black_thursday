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
    total_inventory_array = []
    @se.merchants.all_ids.each do |id|
      total_inventory_array << merchant_items_count(id)
    end
    find_avrg_of_array(total_inventory_array)
  end

  def find_avrg_of_array(array)
    (array.reduce(:+) / array.length.to_f).round(2)
  end

end
