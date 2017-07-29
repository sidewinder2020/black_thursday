module SeMerchantsMethods
  def all_merchant_ids
    @merchants.all_ids
  end

  def get_merchants_total_inventory
    @merchants.get_total_inventory
  end

  def return_merchants_by_item_count_greater_than(outliers)
    @merchants.return_merchants_by_item_count_greater_than(outliers)
  end

  def get_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

end
