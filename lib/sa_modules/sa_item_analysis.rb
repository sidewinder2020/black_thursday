module SaItemAnalysis

  def find_inventory_total_one_std_deviation_above_avrg
    std_dev = find_standard_deviation(merchants_total_inventory)
    mean = find_avrg_of_array(merchants_total_inventory)
    outlier_threshhold = std_dev + mean
    outlier_threshhold
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
end
