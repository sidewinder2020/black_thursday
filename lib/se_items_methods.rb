module SeItemsMethods
  def all_items
    @items.all
  end
  def get_item_prices_by_merchant_id(merchant_id)
    @items.get_item_prices_by_merchant_id(merchant_id)
  end

  def merchant_items_count(merchant_id)
    @items.find_all_by_merchant_id(merchant_id).length
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end
end
