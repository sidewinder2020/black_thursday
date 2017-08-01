module SaMerchantAnalysis
  def merchants_with_high_item_count
    outliers = find_inventory_total_one_std_deviation_above_avrg
    @se.return_merchants_by_item_count_greater_than(outliers)
  end

  def average_items_per_merchant_standard_deviation
    find_standard_deviation(merchants_total_inventory)
  end

  def merchants_total_inventory
    @se.get_merchants_total_inventory
  end

  def average_items_per_merchant
    find_avrg_of_array(merchants_total_inventory)
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

  def get_merchant_by_id(merchant_id)
    @se.get_merchant_by_id(merchant_id)
  end
end
